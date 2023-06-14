require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of :password }
  end

  it 'can generate an API key' do
    @user = User.create!(email: "whatever@example.com", password: "password", password_confirmation: "password")

    expect(@user.api_key).to eq(nil)

    @user.generate_api_key

    expect(@user.api_key).to_not eq(nil)
  end

  it 'can downcase email' do
    @user = User.create!(email: "WHATEVER@example.com", password: "password", password_confirmation: "password")

    expect(@user.email).to eq("whatever@example.com")
  end
end