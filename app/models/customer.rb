class Customer < ApplicationRecord
  belongs_to :organization, optional: true

  has_many :addresses, as: :addressable, dependent: :destroy

  has_one :billing_address, -> { where(address_type: :billing) }, as: :addressable, class_name: "Address", dependent: :destroy
  has_one :delivery_address, -> { where(address_type: :delivery) }, as: :addressable, class_name: "Address", dependent: :destroy

  accepts_nested_attributes_for :billing_address, allow_destroy: true
  accepts_nested_attributes_for :delivery_address, allow_destroy: true
end
