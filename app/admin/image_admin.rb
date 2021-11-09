ActiveAdmin.register Image do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :imagable_type, :imagable_id, :image, :main_model_image

  form do |f|
    f.object.imagable_type = 'Model'
    f.inputs do
      f.input :imagable_type, as: :select, collection: ['Model', 'Brand']
      f.input :imagable_id, as: :select, collection: Model.select(:name, :id) + Brand.select(:name, :id)
      f.input :image, as: :file
      f.input :main_model_image
    end
    f.actions
  end

  index do
    id_column
    column :imagable_type
    column :imagable
    column :image_data
    toggle_bool_column :main_model_image, if: proc { |image|
      image.imagable_type == 'Model' && (image.main_model_image || !image.imagable.main_image)
    }
    actions
  end

  show do
    attributes_table do
      row :id
      row :imagable_type
      row :imagable
      row :image_data
      row(:image) do |image|
        image_tag(image.image_url)
      end
    end
  end

  filter :imagable_type, as: :select, collection: ['Model', 'Brand']
  filter :imagable_id, as: :select, collection: Model.select(:id, :name), multiple: true,
                       label: I18n.t('activerecord.models.model.other')
end
