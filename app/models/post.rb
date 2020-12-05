class Post < ApplicationRecord
  has_rich_text :content
  has_rich_text :step1
  has_rich_text :step2
  has_rich_text :step3
  validates :content,:title,:step1,:step2,:step3, {presence: true}
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  def user
    return User.find_by(id: self.user_id)
  end

  def self.search(search)
    return Post.all unless search
    Post.where(['title LIKE ?', "%#{search}%"])
  end

end
