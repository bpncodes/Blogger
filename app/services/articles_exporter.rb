require 'csv'
class ArticlesExporter
  attr_reader :articles_for_upload

  def initialize(current_user, article = Article.all)
    @articles_for_upload = article
    @current_user = current_user
  end

  def call
    export
  end

  def export
    csv_data = CSV.generate do |csv|
      csv << %w[article_id Title Content]
      @articles_for_upload.each do |article| # dont need @ here
        csv << [article.id, article.title, article.content]
      end
    end
    ExportMailer.export_mail(@current_user, csv_data).deliver
  end

  # def after(job)
  #   User.find(@current_user_id).update_attributes(csv_download: true)
  # end
  # handle_asynchronously :export
end
