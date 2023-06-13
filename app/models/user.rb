class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates_presence_of :password

  has_secure_password

  before_save :downcase_email

  def generate_api_key
    if self.api_key == nil
      self.api_key = SecureRandom.urlsafe_base64(25).to_s
      self.save
    end
  end

  private

  def downcase_email
    return if email.nil?

    self.email =email.downcase
  end
end
