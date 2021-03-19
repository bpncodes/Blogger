class CsvMailer
  attr_reader :articles_for_upload

  def initialize(article, comment)
    @article = article
    @comment = comment
  end

  def call
    export
  end

  def export
    WelcomeMailer.custom_mail(@article.user, 'A new Comment has been added', @comment).deliver
  end
end
