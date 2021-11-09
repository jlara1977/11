require 'write_xlsx'

ActiveAdmin.register PriceVersion do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :car_id, :monthly_price_cents, :monthly_price_currency, :annual_distance,
                :contract_time

  index do
    id_column
    column(:car) { |model| model.car.name }
    column(:monthly_price_cents) { |model| model.monthly_price.format(symbol: true) }
    column :monthly_price_currency
    column :annual_distance
    column :contract_time
    column :created_at
    column :updated_at
  end

  action_item :upload_file, only: :index do
    link_to(I18n.t('active_admin.price_version.upload_file'),
            upload_file_form_admin_price_versions_path)
  end

  collection_action :upload_file_form, title: I18n.t('active_admin.price_version.upload_file'),
                                       method: :get do
  end

  collection_action :upload_file, method: :post do
    file = params[:price_versions][:file]
    file_type = file.original_filename.split('.')[-1]
    if ['xls', 'xlsx'].include? file_type
      uploaded_file = Shrine.upload(file, :cache)
      ProcessPriceVersionsFileJob.perform_later(uploaded_file.url)
      redirect_to(admin_price_versions_path,
                  notice: I18n.t('active_admin.price_versions.success_upload'))
    else
      redirect_to(admin_price_versions_path,
                  alert: I18n.t('active_admin.price_versions.upload_error'))
    end
  end

  collection_action :download_xlsx, title: 'download_xlsx', method: :post do
    file_path = "/tmp/price_versions-#{Time.zone.now}.xlsx"
    workbook  = WriteXLSX.new(file_path)
    worksheet = workbook.add_worksheet('price_versions')
    worksheet.write_row(0, 0,
                        ['car_id'] + PriceVersion.combined_contract_time_with_annual_distances +
                        ['valid_date'])
    Car.all.each_with_index do |car, index|
      car_prices = PriceVersion.combined_contract_time_with_annual_distances.map do |key|
        contract_time, annual_distance = key.split('-')
        price_version = car.price_versions.where(contract_time: contract_time,
                                                 annual_distance: annual_distance).first
        price_version.present? ? price_version.monthly_price_cents : nil
      end
      worksheet.write_row(index + 1, 0, [car.id] + car_prices + [car.last_valid_date_prices])
    end
    workbook.close
    send_file file_path
  end
end
