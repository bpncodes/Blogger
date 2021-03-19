class ExportMailer < ApplicationMailer
  default from: 'mabezat777@gmail.com'
  def export_mail(user, data)
    @user = user
    @data = data
    attachments["articles_data_#{Time.now.getutc}.csv"] = { mime_type: 'text/csv',
                                         content: @data }

    mail(to: email_address_with_name(@user.email, @user.username), subject: 'CSV Files exported')
  end
end
