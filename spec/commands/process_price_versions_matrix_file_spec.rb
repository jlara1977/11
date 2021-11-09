require 'rails_helper'

describe ProcessPriceVersionsMatrixFile do
  def perform
    described_class.for(file_url: file_url)
  end

  let(:file_url) { double }
  let(:spreadsheet) { double }
  let(:car_versions) { create_list(:car, 3) }
  let(:price_versions) do
    car_versions.map { |car_version| create(:price_version, car: car_version) }
  end
  let(:parse_spreadsheet) do
    hash_rows = []
    hash_rows.insert(0, ['car_id'] + PriceVersion.combined_contract_time_with_annual_distances)
    car_versions.each_with_index do |car, index|
      hash_row = { 'car_id': car.id }
      PriceVersion.combined_contract_time_with_annual_distances.map do |key|
        contract_time, annual_distance = key.split('-')
        selected_price_version = price_versions.find do |price_version|
          price_version.car_id == car.id && price_version.contract_time == contract_time &&
            price_version.annual_distance == annual_distance
        end
        if selected_price_version.present?
          hash_row["#{contract_time}-#{annual_distance}"] =
            selected_price_version.monthly_price_cents + amount
        end
      end
      hash_row = hash_row.deep_stringify_keys
      hash_rows.insert(index + 1, hash_row)
    end
    hash_rows
  end

  before do
    allow(Roo::Spreadsheet).to receive(:open).and_return(spreadsheet)
  end

  describe '#perform' do
    let(:amount) { 10 }

    before do
      allow(spreadsheet).to receive(:parse).and_return(parse_spreadsheet)
      perform
    end

    context 'when price_versions already exists' do
      let!(:old_prices) do
        price_versions.map do |price_version|
          [price_version.id, price_version.monthly_price_cents]
        end.to_h
      end

      it 'update monthly_price_cents by the defined amount' do
        price_versions.each do |price_version|
          price_version.reload
          expect(price_version.monthly_price_cents).to eq(old_prices[price_version.id] + amount)
        end
      end
    end

    context 'when price_versions do not previously exist' do
      let(:contract_time) { '12' }
      let(:annual_distance) { '18.000' }
      let(:new_price_versions) do
        car_versions.map do |car_version|
          {
            'car_id': car_version.id,
            "#{contract_time}-#{annual_distance}": 300000
          }.stringify_keys
        end
      end
      let(:parse_spreadsheet) do
        hash_rows = new_price_versions.dup
        hash_rows.insert(0, ['car_id'] + PriceVersion.combined_contract_time_with_annual_distances)
        hash_rows
      end

      it 'creates new price version' do
        new_price_versions.each do |price_version|
          expect(PriceVersion
            .find_by(
              car_id: price_version['car_id'],
              contract_time: contract_time,
              annual_distance: annual_distance
            )).not_to be(nil)
        end
      end
    end
  end
end
