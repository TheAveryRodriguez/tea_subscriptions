class Subscription < ApplicationRecord
  validates :title, presence: true
  validates :price, presence: true, numericality: true
  validates :status, presence: true, numericality: true
  validates :frequency, presence: true, numericality: true

  enum status: [:active, :cancelled]

  belongs_to :customer
  has_many :tea_subscriptions
  has_many :teas, through: :tea_subscriptions
end
