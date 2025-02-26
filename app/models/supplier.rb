class Supplier < ApplicationRecord
  belongs_to :organization, optional: true
  has_many :addresses, as: :addressable
end
