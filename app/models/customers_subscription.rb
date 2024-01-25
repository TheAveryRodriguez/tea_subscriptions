class CustomersSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription
  validates :status, presence: true

  enum status: {
    active: 0,
    cancelled: 1
  }
end
