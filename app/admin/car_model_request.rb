ActiveAdmin.register CarModelRequest do
  menu parent: I18n.t('active_admin.titles.requests')

  permit_params :id, :email, :brand, :model, :annual_distance, :contract_time
end
