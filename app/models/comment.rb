class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user
  paginates_per 2
  def comment_username
    user.username
  end

end
