require 'rails_helper'

RSpec.describe ImportRidersService, type: :service do
  let(:certifier) { create(:certifier) }
  let(:admin) { create(:admin, certifier: certifier)}
  let(:import) { create(:import, admin: admin) }
  let(:import_json) { create(:import, admin: admin, file_type: 'json')}

  describe "Import Riders Service" do
    describe "csv" do
      it "#import" do
        ImportRidersService.new(import, 'Test Certifier').import

        expect(import.imported_at).not_to be_nil
        expect(import.riders.count).to eq(2)
      end
    end


    it "#import json" do
      ImportRidersService.new(import_json, 'Test Certifier').import

      expect(import_json.imported_at).not_to be_nil
      expect(import_json.riders.count).to eq(3)
    end
  end
end