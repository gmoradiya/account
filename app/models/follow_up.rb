class FollowUp < ApplicationRecord
  belongs_to :patient
  belongs_to :user
  has_one_attached :pdf
  has_many :prescriptions
  before_destroy :delete_pdf

  private

  def delete_pdf
    pdf.purge if pdf.attached?
  end

end
