ActiveAdmin.register ReservationRequest do
  menu parent: I18n.t('active_admin.titles.requests')

  permit_params :id, :car_id, :price_version_id, :email, :first_name, :last_name, :contact_number,
                :kind, :comment

  index do
    column :id
    column :car
    column :model
    column :first_name
    column :last_name
    column :contact_number
    column :email
    column :price_version
    column :kind
    column :comment
    column :created_at
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :contact_number
      f.input(
        :kind,
        as: :select,
        collection: EnumUtils.enum_options_for_select(ReservationRequest, :kind)
      )
      f.input :price_version
      f.input :car
      f.input :comment
    end
    f.actions
  end
end
