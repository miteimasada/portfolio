class Post < ApplicationRecord
  has_rich_text :content
  validates :content, {presence: true}
  belongs_to :user, dependent: :destroy
  has_many :likes, dependent: :destroy

  def user
    return User.find_by(id: self.user_id)
  end

  def self.search(search)
    return Post.all unless search
    Post.where(['title LIKE ?', "%#{search}%"])
  end

end
