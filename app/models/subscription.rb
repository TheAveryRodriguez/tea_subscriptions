class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true, numericality: true
  validates :status, presence: true
  validates :frequency, presence: true, numericality: true

  enum status: {
    active: 0,
    cancelled: 1
  }

  has_many :customers_subscriptions
  has_many :customers, through: :customers_subscriptions

  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end
