RESERVATION_REQUEST_SCHEMA = {
  type: :object,
  properties: {
    car_id: { type: :integer },
    price_version_id: { type: :integer },
    email: { type: :string },
    first_name: { type: :string },
    last_name: { type: :string },
    contact_number: { type: :string },
    kind: { type: :string },
    comment: { type: :string }
  },
  required: ['car_id', 'price_version_id', 'email', 'first_name', 'last_name']
}
