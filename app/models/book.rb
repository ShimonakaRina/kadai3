class Book < ApplicationRecord
    belongs_to :user
    attachment :profile_image
    has_many :favorites, dependent: :destroy
    has_many :favorited_users, through: :favorites, source: :user
    has_many :book_comments, dependent: :destroy
    has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  
  # 今日投稿された Book を取得
  scope :created_today, -> { where(created_at: Time.zone.now.beginning_of_day) }

  # 昨日投稿された Book を取得
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  
  is_impressionable counter_cache: true
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
