ActiveAdmin.register Document do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :documentable_type, :documentable_id, :document

  form do |f|
    f.object.documentable_type = 'Model'
    f.inputs do
      f.input :documentable_type, as: :select, collection: ['Model']
      f.input :documentable_id, as: :select, collection: Model.pluck(:name, :id)
      f.input :document, as: :file
    end
    f.actions
  end

  filter :documentable_type, as: :select, collection: ['Model']
  filter :documentable_id, as: :select, collection: -> { Model.pluck(:name, :id) }, multiple: true,
                           label: I18n.t('activerecord.models.model.other')
end
