class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name

  def self.find_by_except_password (arg1)
    exclude_columns = ['password']
    self.find_by(email: arg1)
  end
end
