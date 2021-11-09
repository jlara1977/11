class Api::V1::CarSerializer < ActiveModel::Serializer
  attributes :id, :shift, :fuel, :model_name, :brand_name, :name, :traction, :row_seats, :airbags,
             :annual_distances, :formatted_last_valid_date_prices

  has_many :comfort_characteristics,
           serializer: Api::V1::CharacteristicSerializer, if: :with_characteristics?
  has_many :multimedia_characteristics,
           serializer: Api::V1::CharacteristicSerializer, if: :with_characteristics?
  has_many :security_characteristics,
           serializer: Api::V1::CharacteristicSerializer, if: :with_characteristics?

  has_many :price_versions, serializer: Api::V1::PriceVersionSerializer

  def formatted_last_valid_date_prices
    I18n.l(object.last_valid_date_prices, format: '%B %Y') if object.last_valid_date_prices.present?
  end

  def with_characteristics?
    @instance_options[:with_characteristics]
  end

  def shift
    EnumUtils.enum_i18n(Car, :shift, object.shift)
  end

  def fuel
    EnumUtils.enum_i18n(Car, :fuel, object.fuel)
  end

  def traction
    EnumUtils.enum_i18n(Car, :traction, object.traction)
  end

  def annual_distances
    PriceVersion.where(car: object).select(:annual_distance).distinct.pluck(:annual_distance)
  end

  def name
    object.version_name || object.name
  end

  def model_name
    object.model.name
  end

  def brand_name
    object.brand.name
  end
end
