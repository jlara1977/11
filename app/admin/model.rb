ActiveAdmin.register Model do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :name, :brand_id, :car_type, :active, :prioritized_display,
                characteristings_attributes: [:id, :characteristic_id, :_destroy],
                characteristing_ids: [:id], characteristic_ids: [:id, :name]

  index do
    id_column
    column :name
    column :brand
    column :car_type
    toggle_bool_column :active
    toggle_bool_column :prioritized_display, if: proc { |model|
      model.prioritized_display ||
        Model.prioritized_display.size < ENV['MAX_PRIORITIZED_MODELS'].to_i
    }
    actions
  end

  preserve_default_filters!
  remove_filter :characteristings
  remove_filter :images
  remove_filter :price_versions
  filter :car_type, as: :select, multiple: true,
                    collection: EnumUtils.enum_options_for_filter(Model, :car_type)
  filter :brand, as: :select, multiple: true
  filter :cars, as: :select, multiple: true

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
      f.input :name
      f.input :brand
      f.input(
        :car_type,
        as: :select,
        collection: EnumUtils.enum_options_for_select(Model, :car_type)
      )
    end
    f.inputs do
      f.has_many :characteristings, allow_destroy: true do |t|
        t.input :characteristic
      end
    end
    f.actions
  end
end
