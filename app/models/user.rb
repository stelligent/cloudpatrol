class User < ActiveRecord::Base
  has_secure_password

  before_create :generate_api_token

  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :password

private

  def generate_api_token
    require 'securerandom'
    begin
      self.api_key = SecureRandom.hex
    end while User.exists?(api_key: api_key)
  end
end
