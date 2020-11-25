require 'rails_helper'

RSpec.describe Post, type: :model do

  it "タイトルと本文があれば投稿できる" do
    post = FactoryBot.create(:post)
    expect(post).to be_valid
  end

  it "タイトルが無いと投稿出来ない" do
    post = FactoryBot.build(:post, title: nil)
    post.valid?
    expect(post.errors[:title]).to_not include("を入力して下さい")
  end

  it "本文が無いと投稿出来ない" do
    post = FactoryBot.build(:post, content: nil)
    post.valid?
    expect(post.errors[:content]).to_not include("を入力して下さい")
  end

end
