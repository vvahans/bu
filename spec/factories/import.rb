FactoryBot.define do
  factory :import do
    transient do
      file_type { 'csv' }
    end

    admin
    file do
      if file_type == 'csv'
        Rack::Test::UploadedFile.new('spec/fixtures/riders.csv', 'application/csv')
      else
        Rack::Test::UploadedFile.new('spec/fixtures/riders.json', 'application/json')
      end
    end
  end
end