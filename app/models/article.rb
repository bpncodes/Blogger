class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :content, presence: true
  validates :user_id, presence: true
  has_many :comments, dependent: :destroy
  has_one :image, as: :imageable
  acts_as_votable
  paginates_per 2
  scope :recent, -> { order('articles.updated_at DESC') }
  def article_username
    user.username
  end

  def article_image_picture_url
    image.picture.url
  end

end
