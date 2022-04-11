class CertificateMailer < ApplicationMailer
  after_action :update_send_at

  def certificate_email
    @rider = params[:rider]
    attachments['rider-certificate.pdf'] = @rider.certificate.download

    mail(to: @rider.email, subject: 'Rider Certificate')
  end

  private

  def update_send_at
    @rider.update(certificate_send_at: DateTime.now)
  end
end
