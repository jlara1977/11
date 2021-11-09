ActiveAdmin.register Characteristic do
  menu parent: I18n.t('active_admin.titles.car_options')

  permit_params :id, :name, :category

  form do |f|
    f.inputs do
      f.input :name
      f.input(
        :category,
        as: :select,
        collection: EnumUtils.enum_options_for_select(Characteristic, :category)
      )
    end
    f.actions
  end

  filter :id
  filter :name
  filter :category, as: :select, multiple: true,
                    collection: EnumUtils.enum_options_for_filter(Characteristic, :category)
end
