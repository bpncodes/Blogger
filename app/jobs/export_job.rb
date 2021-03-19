require 'csv'
class ExportJob < ApplicationJob
  queue_as :default

  def perform(articles_for_upload, user_id)
    @user_id = user_id
    CSV.open("tmp/exports/#{Time.now.getutc}.csv", 'w+') do |csv|
      csv << ['ID']
      articles_for_upload.each do |site|
        csv << [site.Title]
      end
    end
    User.find(@user_id).update_attribute(:csv_download, true)

    # send_data csv_string,
    # type: 'text/csv',
    # filename: "#{Time.now.getutc}_articles.csv",
    # disposition: 'attachment',
    # notice: 'Articles were exported sucessfully'
  end

  handle_asynchronously :perform
end

# # Do something later
# csv_content = File.open('data.csv', 'w+') do |f|
#   # articles_for_upload.each do |one|
#   f << ("title : #{articles_for_upload.title},content : #{articles_for_upload.content} \n")
#   # end
# end
# ActionCable.server.broadcast(
#   'export_channel',
#   csv_file: {
#     file_name: 'data.csv',
#     content: csv_content
#   }
# )
