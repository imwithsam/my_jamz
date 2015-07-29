class User < ActiveRecord::Base
  has_many :songs
  
  validates :username, presence: true, uniqueness: true
  has_secure_password
  enum role: %w(default admin)
end
