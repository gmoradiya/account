class Patient < ApplicationRecord
  has_many :follow_ups
  has_many :appointments
  has_one_attached :photo
  has_one_attached :signature

  validates :case_number, uniqueness: true

  before_destroy :delete_attachment
  before_create :generate_case_number


  def age
    return unless date_of_birth.present?
    
    today = Date.today
    age = today.year - date_of_birth.year
    age -= 1 if today < date_of_birth + age.years # Adjust for birthday not yet reached this year
    age
  end

  def generate_case_number
    return if self.case_number.present?
    last_case = Patient.order(case_number: :desc).first
    self.case_number = next_case_number(last_case&.case_number)
  end

  private

  def delete_attachment
    photo.purge if photo.attached?
    signature.purge if signature.attached?
  end

  # def generate_case_number
  #   last_case = Patient.order(case_number: :desc).first
  #   self.case_number = next_case_number(last_case&.case_number)
  # end

  def next_case_number(last_number)
    if last_number.nil?
      return "AH001"  # First case
    end

    prefix, number = last_number.scan(/([A-Z]+)(\d+)/).first
    number = number.to_i + 1

    if number > 999  # Move to next prefix when limit is reached
      prefix = increment_prefix(prefix)
      number = 1
    end

    "#{prefix}#{number.to_s.rjust(3, '0')}" # Formats as AH001, AH002...
  end
    
  def increment_prefix(prefix)
    first_letter, second_letter = prefix.chars

    if second_letter == "H"
      first_letter = first_letter.next  # Increment A → B, B → C, etc.
      second_letter = "H"  # Keep second letter fixed as "H"
    end

    "#{first_letter}H"
  end
end
