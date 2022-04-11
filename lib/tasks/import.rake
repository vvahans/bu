namespace :import do
  desc "Processing imported files, generating certificates and sending emails"
  task process_rider_certificates: :environment do
    ImportProcessorJob.perform_later
  end
end