class User < ApplicationRecord
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true, length: { in: 2..24 }
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, length: { in: 6..20 }, confirmation: true
  has_secure_password
  has_many :authentications, dependent: :destroy
end
