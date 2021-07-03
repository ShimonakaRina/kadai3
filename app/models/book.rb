class Book < ApplicationRecord
    belongs_to :user
    attachment :profile_image
    has_many :favorites, dependent: :destroy
    has_many :book_comments, dependent: :destroy
    has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
