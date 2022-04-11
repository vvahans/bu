require "csv"
require "prawn"

class ImportRidersService
  attr_accessor :errors

  def initialize(import, certifier_name)
    @import_record = import
    @certifier_name = certifier_name
  end

  def import
    parsed_file = CSV.parse(@import_record.file.download, headers: true)
    failed_attempts = 0

    parsed_file.each do |record|
      begin
        rider = Rider.create!(first_name: record[0], last_name: record[1], email: record[2], import: @import_record)
        rider.certificate.attach(
          io: StringIO.new(generate_certificate_for(rider)),
          filename: "Certificate-#{rider.full_name}.pdf",
          content_type: "application/pdf"
        )
        rider.save!

        CertificateMailer.with(rider: rider).certificate_email.deliver_later
      rescue => e
        failed_attempts += 1
        Rails.logger.warn(e.message)
      end
    end

    @import_record.failed_records = failed_attempts
    @import_record.total_records = parsed_file.size
    @import_record.save!
  end

  private

  def generate_certificate_for(rider)
    Prawn::Document.new(:page_size => 'A4', :top_margin => 30, :left_margin => 30) do |certificate|
      certificate.text "Bikes Unlimited Certificate"
      certificate.text "Certification Center: #{@certifier_name}"
      certificate.text "Holder Name: #{rider.full_name}"
      certificate.text "Issue Date: #{rider.created_at.strftime('%m-%d-%Y')}"
    end.render
  end
end