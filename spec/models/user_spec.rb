require 'rails_helper'

RSpec.describe User, type: :model do

  it "名前とメールアドレスとパスワードがあれば登録できる" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "名前がなければ登録できない" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?

    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスがなければ登録できない" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?

    expect(user.errors[:email]).to include("を入力してください")
  end

  it "メールアドレスが重複していたら登録できない" do
    user1 = FactoryBot.create(:user,name: "taro", email: "taro@example.com")
    expect(FactoryBot.build(:user, name: "ziro", email: user1.email)).to_not be_valid
  end

  it "パスワードがなければ登録できない" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?

    expect(user.errors[:password]).to include("を入力してください")
  end

  it "パスワードが暗号化されているか" do
    user = FactoryBot.create(:user)
    expect(user.password_digest).to_not eq "password"
  end

end
