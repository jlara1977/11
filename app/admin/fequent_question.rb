ActiveAdmin.register FrequentQuestion do
  permit_params :id, :question, :answer, :category

  preserve_default_filters!
  filter :category, as: :select, multiple: true,
                    collection: EnumUtils.enum_options_for_filter(FrequentQuestion, :category)

  form do |f|
    f.inputs do
      f.input :question
      f.input :answer
      f.input(
        :category,
        as: :select,
        collection: EnumUtils.enum_options_for_select(FrequentQuestion, :category)
      )
    end
    f.actions
  end

  index do
    column :id
    column :question
    column :answer
    column :category
    actions
  end
end
