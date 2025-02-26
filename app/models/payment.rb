class Payment < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :billable, polymorphic: true
  belongs_to :organization, optional: true
  enum :payment_mode, { cash: 0, bank_transfer: 1, check: 2 }

  after_create :settle_invoice

  def party_name
    (billable_type == "SalesInvoice" || billable_type == "SalesReturnInvoice") ? billable&.customer&.name : billable&.supplier&.name
  end

  private

  def settle_invoice
    self.update(bill_no: billable.bill_no)
    if billable_type == "SalesInvoice" || billable_type == "PurchaseReturnInvoice"
      billable.update(received_amount: billable.received_amount.to_f + amount)
      if billable.received_amount == billable.grand_total
        billable.update(payment_status: :paid)
      elsif billable.received_amount < billable.grand_total
        billable.update(payment_status: :partially_paid)
      end
    elsif billable_type == "PurchaseInvoice" || billable_type == "SalesReturnInvoice"
      billable.update(paid_amount: billable.paid_amount.to_f + amount)
      if billable.paid_amount == billable.grand_total
        billable.update(payment_status: :paid)
      elsif billable.paid_amount < billable.grand_total
        billable.update(payment_status: :partially_paid)
      end
    end
  end
end
