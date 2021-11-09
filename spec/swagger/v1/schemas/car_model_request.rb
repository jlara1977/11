CAR_MODEL_REQUEST_SCHEMA = {
  type: :object,
  properties: {
    first_name: { type: :string },
    last_name: { type: :string },
    email: { type: :string },
    brand: { type: :string },
    model: { type: :string },
    annual_distance: { type: :string },
    contract_time: { type: :string },
    phone_number: { type: :string },
    comment: { type: :string }
  },
  required: ['first_name', 'last_name', 'email', 'brand', 'model', 'annual_distance',
             'contract_time', 'phone_number']
}
