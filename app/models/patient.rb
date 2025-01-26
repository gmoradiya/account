class Patient < ApplicationRecord
  has_many :follow_ups
  has_many :appointments
  has_one_attached :photo
  has_one_attached :signature

  validates :case_number, uniqueness: true

  def age
    return unless date_of_birth.present?
    
    today = Date.today
    age = today.year - date_of_birth.year
    age -= 1 if today < date_of_birth + age.years # Adjust for birthday not yet reached this year
    age
  end
    
end
