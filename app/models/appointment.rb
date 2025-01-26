class Appointment < ApplicationRecord
  include ActiveModel::Validations

  belongs_to :patient, optional: true
  has_many :prescriptions
  validates :appointment_status, presence: true

  enum :appointment_status, { waiting: 0, followup: 1, complete: 2 }
  enum :appointment_type, {allopathy: 0, homeopathy: 1}
end
