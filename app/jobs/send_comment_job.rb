class SendCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    # Do something later
    # com = ApplicationController.render(
    #   partial: 'comments/comment',
    #   locals: { comment: comment }
    # )
    # ActionCable.server.broadcast 'comment_channel', comment: comment, html: com
  end
end
