class Product < ApplicationRecord
  belongs_to :organization, optional: true
  belongs_to :hsn, optional: true

  has_many :sales_inventories, dependent: :destroy
  has_many :sales_invoices, through: :sales_inventories
  has_many :customers, through: :sales_invoices
  has_many :purchase_inventories, dependent: :destroy
  has_many :purchase_invoices, through: :purchase_inventories
  has_many :suppliers, through: :purchase_invoices
  has_many :job_inventories, dependent: :destroy
  has_many :job_invoices, through: :job_inventories
end
