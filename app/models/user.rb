class User < ActiveRecord::Base
  has_secure_password

  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :password
end
