require 'swagger_helper'

RSpec.describe 'api/v1/car_model_requests', type: :request do
  path '/car_model_requests' do
    post('create car_model_request') do
      tags 'Car Model Resquests'
      consumes 'application/json'
      parameter name: :car_model_request, in: :body, schema: {
        '$ref' => '#/definitions/car_model_request_schema'
      }

      response(201, 'Car Model Request created') do
        let(:first_name) { Faker::Name.first_name }
        let(:last_name) { Faker::Name.last_name }
        let(:email) { Faker::Internet.email }
        let(:brand) { Faker::Vehicle.make }
        let(:model) { Faker::Vehicle.model(make_of_model: brand) }
        let(:annual_distance) { CarModelRequest.annual_distances.keys.first }
        let(:contract_time) { CarModelRequest.contract_times.keys.first }
        let(:phone_number) { 999999999 }
        let(:car_model_request) do
          { 'email': email, 'brand': brand, 'model': model, 'annual_distance': annual_distance,
            'contract_time': contract_time, 'first_name': first_name, 'last_name': last_name,
            'phone_number': phone_number }
        end

        run_test!
      end

      response(400, 'Incomplete Parameters') do
        let(:car_model_request) { {} }

        run_test!
      end
    end
  end
end
