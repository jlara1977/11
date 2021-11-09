class Api::V1::ReservationRequestSerializer < ActiveModel::Serializer
  attributes :id, :car_id, :email, :first_name, :last_name, :contact_number, :kind, :comment
end
