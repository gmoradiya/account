class UserOrganization < ApplicationRecord
  belongs_to :user
  belongs_to :organization

  before_create :add_role

  def add_role
    self.role = "staff"
  end
end
