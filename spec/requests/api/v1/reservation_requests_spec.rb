require 'swagger_helper'

RSpec.describe 'api/v1/reservation_requests', type: :request do
  path '/reservation_requests' do
    post('create reservation_request') do
      tags 'Reservation Resquests'
      consumes 'application/json'
      parameter name: :reservation_request, in: :body, schema: {
        '$ref' => '#/definitions/reservation_request_schema'
      }

      response(201, 'Reservation Request created') do
        let(:car)  { create(:car) }
        let(:price_version) { create(:price_version, car: car) }
        let(:email) { Faker::Internet.email }
        let(:first_name) { Faker::Name.first_name }
        let(:last_name) { Faker::Name.last_name }
        let(:reservation_request) do
          { 'car_id': car.id, 'price_version_id': price_version.id, 'email': email,
            'first_name': first_name, 'last_name': last_name }
        end

        run_test!
      end

      response(400, 'Incomplete Parameters') do
        let(:reservation_request) { {} }

        run_test!
      end
    end
  end
end
