class Invitation < ApplicationRecord
  belongs_to :organization
  before_create :generate_token

  private

  def generate_token
    self.token = SecureRandom.hex(10) # Generates a unique token for signup
  end
end
