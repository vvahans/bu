require "csv"
require "prawn"

class ImportRidersService
  def initialize(import, certifier_name)
    @import_record = import
    @certifier_name = certifier_name
    @import_file_content_type = import.file.content_type
  end

  def import
    parsed_file = parse(@import_record.file.download, @import_file_content_type)
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

        CertificateMailer.with(rider: rider).certificate_email.deliver_now
      rescue => e
        failed_attempts += 1
        Rails.logger.warn(e.message)
      end
    end

    save_import(@import_record, failed_attempts, parsed_file.size)
  end

  private

  def save_import(import_record, failed_attempts, total_records)
    import_record.failed_records = failed_attempts
    import_record.total_records = total_records
    import_record.imported_at = DateTime.now
    import_record.save!
  end

  def generate_certificate_for(rider)
    Prawn::Document.new(:page_size => 'A4', :top_margin => 30, :left_margin => 30) do |certificate|
      certificate.text "Bikes Unlimited Certificate"
      certificate.text "Certification Center: #{@certifier_name}"
      certificate.text "Holder Name: #{rider.full_name}"
      certificate.text "Issue Date: #{rider.created_at.strftime('%m-%d-%Y')}"
    end.render
  end

  def parse(file, content_type)
    if content_type == 'application/csv'
      parse_csv(file)
    elsif content_type == 'application/json'
      parse_json(file)
    else
      raise 'Unknown Content Type for Import file'
    end
  end

  def parse_csv(file)
    CSV.parse(file, headers: true)
  end

  def parse_json(file)
    licences = JSON.parse(file)
    licences["licences"].reduce([]){ |memo, rider| memo << [rider['name'], rider['surname'], rider['email']] }
  end
end