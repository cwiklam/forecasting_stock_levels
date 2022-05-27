class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_accessor :confirm_password

  validates :email, presence: true, uniqueness: { :case_sensitive => true }
  validates :password, presence: true
  validate :confirm_password_the_same, unless: :create_new_user

  private

  def confirm_password_the_same
    return if password == confirm_password

    errors.add(:confirm_password, 'Hasła nie są takie same')
  end

  def create_new_user
    persisted?
  end
end
