ActiveAdmin.register Car do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :model_id, :shift, :fuel, :traction, :version_name, :airbags, :row_seats,
                :last_valid_date_prices,
                characteristings_attributes: [:id, :characteristic_id, :_destroy],
                characteristing_ids: [:id], characteristic_ids: [:id, :name]

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row field
      end
      row(:characteristics) { |model| model.characteristics }
    end
  end

  form do |f|
    f.inputs do
      f.input(
        :model,
        as: :select,
        collection: Model.all.map { |model| [model.name, model.id] }
      )
      f.input(
        :shift,
        as: :select,
        collection: EnumUtils.enum_options_for_select(Car, :shift)
      )
      f.input(
        :traction,
        as: :select,
        collection: EnumUtils.enum_options_for_select(Car, :traction)
      )
      f.input(
        :fuel,
        as: :select,
        collection: EnumUtils.enum_options_for_select(Car, :fuel)
      )
      f.input :version_name
      f.input :airbags
      f.input :row_seats
      f.input :last_valid_date_prices
    end
    f.inputs do
      f.has_many :characteristings, allow_destroy: true do |t|
        t.input :characteristic
      end
    end
    f.actions
  end
end
