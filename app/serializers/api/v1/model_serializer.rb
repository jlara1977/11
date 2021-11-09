class Api::V1::ModelSerializer < ActiveModel::Serializer
  attributes :id, :name, :brand_name, :car_type, :fuel_options, :shift_options,
             :minimum_price, :main_image_url, :formatted_minimum_price, :traction_options,
             :prioritized_display

  has_many :comfort_characteristics,
           serializer: Api::V1::CharacteristicSerializer, if: :with_characteristics?
  has_many :multimedia_characteristics,
           serializer: Api::V1::CharacteristicSerializer, if: :with_characteristics?
  has_many :security_characteristics,
           serializer: Api::V1::CharacteristicSerializer, if: :with_characteristics?

  has_many :cars, serializer: Api::V1::CarSerializer, if: :with_cars?
  has_many :images, serializer: Api::V1::ImageSerializer, if: :with_images?
  has_one :technical_file, serializer: Api::V1::DocumentSerializer

  def with_characteristics?
    @instance_options[:with_characteristics]
  end

  def with_cars?
    @instance_options[:with_cars]
  end

  def with_images?
    @instance_options[:with_images]
  end

  def brand_name
    object.brand.name
  end

  def car_type
    object.car_type.nil? ? '' : EnumUtils.enum_i18n(Model, :car_type, object.car_type)
  end

  def fuel_options
    object.cars.pluck(:fuel).uniq.map { |fuel_option| EnumUtils.enum_i18n(Car, :fuel, fuel_option) }
  end

  def shift_options
    object.cars.pluck(:shift).uniq.map do |shift_option|
      EnumUtils.enum_i18n(Car, :shift, shift_option)
    end
  end

  def traction_options
    object.cars.pluck(:traction).uniq.map do |traction_option|
      EnumUtils.enum_i18n(Car, :traction, traction_option)
    end
  end

  def price_options
    @price_options ||= object.price_versions.pluck(:monthly_price_cents)
  end

  def minimum_price
    @minimum_price ||= price_options.min || 0
  end

  def formatted_minimum_price
    Money.new(minimum_price, :CLP).format(symbol: true, with_currency: false, format: "%u%n")
  end

  def main_image_url
    object.main_image&.image_url(:search_view_webp) ||
      ActionController::Base.helpers.image_url('empty_image.jpg')
  end
end
