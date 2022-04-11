class ImportMailer < ApplicationMailer
  def certifier_import_mailer
    @import = params[:import]
    @certifier = @import.admin.certifier
    mail(to: @certifier.email, subject: 'Summary of Certifier')
  end

  def bikes_unlimited_mailer
    @imports_count = params[:imports_count]
    @total_riders_count = params[:total_riders_count]
    mail(to: 'owner@bikes-unlimited.io', subject: 'Nightly jobs summary')
  end
end
