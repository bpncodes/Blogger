class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  enum role: { admin: 0, editor: 1, normal_user: 2 }, _suffix: true

  has_many :articles, dependent: :destroy
  has_many :comments, through: :articles, dependent: :destroy   # through is not needed
  has_one :image, as: :imageable, dependent: :destroy

  has_one_attached :avatar, dependent: :destroy do |attachable|
    attachable.variant :thumb, resize: '40x40'
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validate :validate_username, :validate_email
  validates_format_of :username, with: /\A[a-zA-Z0-9_]*\z/, multiline: true
  validates :username, presence: true

  acts_as_voter

  def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.username = provider_data.info.email.split('@')[0] + Devise.friendly_token[0, 4].to_s
      user.password = Devise.friendly_token[0, 20]
      user.role = 'normal_user'
      user.save(validate: false)
    end
  end

  def self.create_from_google_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create do |user|
      user.email = provider_data.info.email
      user.username = provider_data.info.email.split('@')[0]+Devise.friendly_token[0, 4].to_s
      user.password = Devise.friendly_token[0, 20]
      user.role = 'normal_user'
      user.save(validate: false)
    end
  end

  def validate_username
    errors.add(:username, :invalid, message: 'already exists') if User.where(username: username).exists?
  end

  def user_articles_count
    articles.all.count
  end

  def validate_email
    errors.add(:email, :invalid, message: 'already exists') if User.where(email: email).exists?
  end

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
