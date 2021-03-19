require 'csv'
class ArticlesImporter
  attr_reader :file_id, :user_id

  def initialize(file_id, user_id)
    @file_id = file_id
    @user_id = user_id
  end

  def call
    import
  end

  private

  def import
    data = CsvFile.find(@file_id).data

    # CSV.foreach(data, headers: true) do |row|
    #   title = row.to_hash['Title']
    #   content = row.to_hash['Content']
    #   User.find(@user_id).articles.create(title: title, content: content) unless present(title) || present(content)
    # end

    CSV.parse(data, headers: true) do |row|
      title = row.to_hash['Title']
      content = row.to_hash['Content']
      article = User.find(@user_id).articles.create(title: title, content: content) unless present(title) || present(content)
      html = ApplicationController.render(
        partial: 'partials/article',
        locals: { article: article}
      )
      CsvFile.find(@file_id).destroy
      ActionCable.server.broadcast 'export_channel', html: html  # Name should be changed to import_channel
    end
  end

  def present(val)
    val.to_s.strip.empty?
  end
end
