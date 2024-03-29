class Tea < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :temperature, presence: true, numericality: true
  validates :brew_time, presence: true, numericality: true

  has_many :tea_subscriptions
  has_many :subscriptions, through: :tea_subscriptions
end
