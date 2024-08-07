class Account < ApplicationRecord
  has_secure_password

  validates :username, presence: true, uniqueness: true
end
