require 'csv'
ExportCsv = Struct.new(:site_ids, :user_id) do
  attr_reader :articles_for_upload

  def initialize(articles_for_upload)
    @articles_for_upload = articles_for_upload
  end

  def perform
    CSV.generate do |csv|
      csv << %w[article_id Title Content]
      @articles_for_upload.each do |article|
        csv << [article.id, article.title, article.content]
      end
    end
    send_data csv_string,
              type: 'text/csv',
              filename: "#{Time.now.getutc}_articles.csv",
              disposition: 'attachment',
              notice: 'Articles were exported sucessfully'
  end

  handle_asynchronously :perform
end
