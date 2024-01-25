class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :address
  validates_uniqueness_of :email
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  has_many :customers_subscriptions
  has_many :subscriptions, through: :customers_subscriptions
end
