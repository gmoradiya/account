class Organization < ApplicationRecord
  belongs_to :country
  belongs_to :state
  has_many :payments
  has_many :customers
  has_many :suppliers
  has_many :sales_invoices
  has_many :sales_return_invoices
  has_many :purchase_invoices
  has_many :purchase_return_invoices
  has_many :job_invoices
  has_many :products
  has_many :invitations

  has_many :user_organizations
  has_many :users, through: :user_organizations
end
