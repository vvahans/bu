class ImportProcessorJob < ApplicationJob
  queue_as :default

  def perform
    not_processed_imports = Import.not_processed

    not_processed_imports.each do |import|
      ImportRidersService.new(import, import.admin.certifier.name).import
    end

    ImportMailer.with(
      imports_count: not_processed_imports.size,
      total_riders_count: not_processed_imports.reload.sum(:total_records)
    ).bikes_unlimited_mailer.deliver_later
  end
end
