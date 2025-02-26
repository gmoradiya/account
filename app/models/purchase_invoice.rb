class PurchaseInvoice < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :supplier
  belongs_to :organization, optional: true
  has_many :purchase_inventories, dependent: :destroy
  has_many :payments, as: :billable

  enum :payment_status, {
          pending: 0,
          paid: 1,
          partially_paid: 2,
          overdue: 3,
          canceled: 4,
          processing: 5,
          failed: 6,
          refunded: 7,
          chargeback: 8,
          written_off: 9
        }

  accepts_nested_attributes_for :purchase_inventories, allow_destroy: true
end
