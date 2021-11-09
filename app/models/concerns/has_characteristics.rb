module HasCharacteristics
  extend ActiveSupport::Concern
  included do
    has_many :characteristings, as: :characteristical, dependent: :destroy
    has_many :characteristics, through: :characteristings
    accepts_nested_attributes_for :characteristings, allow_destroy: true

    def comfort_characteristics
      characteristics.where(category: :comfort)
    end

    def multimedia_characteristics
      characteristics.where(category: :multimedia)
    end

    def security_characteristics
      characteristics.where(category: :security)
    end
  end
end
