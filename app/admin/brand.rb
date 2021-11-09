ActiveAdmin.register Brand do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :name, :landing_view

  index do
    column :id
    column :name
    toggle_bool_column :landing_view,  if: proc { |brand| brand.image.present? }
  end
end
