class EnumUtils
  def self.enum_options_for_select(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, _|
      [enum_i18n(class_name, enum, key), key]
    end
  end

  def self.enum_options_for_filter(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, value|
      [enum_i18n(class_name, enum, key), value]
    end
  end

  def self.enum_options_for_select_in_vue(class_name, enum)
    class_name.send(enum.to_s.pluralize).map do |key, _|
      { key: key, value: enum_i18n(class_name, enum, key) }
    end
  end

  def self.enum_i18n(class_name, enum, key)
    I18n.t("activerecord.enums.#{class_name.model_name.i18n_key}.#{enum.to_s.pluralize}.#{key}")
  end
end
