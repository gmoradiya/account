class Prescription < ApplicationRecord
  belongs_to :appointment
  belongs_to :follow_up
  belongs_to :medicine
end
