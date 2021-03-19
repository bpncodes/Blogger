class SendLikeJob < ApplicationJob
  queue_as :default

  def perform(article)
    # Do something later
    com = ApplicationController.render(
      partial: 'articles/likes',
      locals: { article: article }
    )
    ActionCable.server.broadcast 'likes_channel', article: article, html: com
  end
end
