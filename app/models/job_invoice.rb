class JobInvoice < ApplicationRecord
  scope :by_financial_year, ->(start_date, end_date) { where(date: start_date..end_date) }

  belongs_to :organization, optional: true
  belongs_to :customer
  has_many :job_inventories, dependent: :destroy

  accepts_nested_attributes_for :job_inventories, allow_destroy: true
end
