class SalesReturnInvoice < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :organization, optional: true
  belongs_to :customer
  belongs_to :sales_invoice

  has_many :sales_return_inventories, dependent: :destroy
  has_many :payments, as: :billable

  accepts_nested_attributes_for :sales_return_inventories, allow_destroy: true

  after_create :update_address
  before_create :generate_bill_no

  enum :bill_type, { with_gst: 0, without_gst: 1 }
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

  def generate_bill_no
    last_invoice = SalesReturnInvoice.order(created_at: :desc).first
    last_number = last_invoice&.bill_no&.split("-")&.last.to_i || 0
    self.bill_no = "RINV-#{ (last_number + 1).to_s.rjust(5, "0") }"  # Format: INV-00001
  end

  private

  def update_address
    update(billing_address: customer.billing_address.full_address) if billing_address.nil?
    update(delivery_address: customer.delivery_address.full_address) if delivery_address.nil?
  end
end
