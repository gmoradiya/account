class Address < ApplicationRecord
  belongs_to :state
  belongs_to :country
  belongs_to :addressable, polymorphic: true
  enum :address_type, { billing: 0, delivery: 1 }

  def full_address
    [ address, "#{city} - #{pincode}", "\n #{state.name}", country.name ].compact.join(", ")
  end
end
