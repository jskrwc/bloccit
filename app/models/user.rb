class User < ApplicationRecord
  # nb --  registers inline callback directly after before_save callback
  before_save { self.email = email.downcase if email.present? }

  # Assignment 23
  before_save {self.name = name.split.map(&:capitalize).join(' ') if name.present? }

  # &:method syntax in map is a concise way to call a method on each item in the array

  # nb. Ass 23 solution video runs a new method, to split, cap and rejoin...
  # so it creates and calls def format_name.....


  validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, if: "password_digest.nil?"
  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

# nb - need install BCrypt to use has_secure_password method
  has_secure_password
end
