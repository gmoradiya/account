class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_organizations
  has_many :organizations, through: :user_organizations
  has_many :follow_ups

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def active_for_authentication?
    super && is_active?
  end

  def inactive_message
    is_active? ? super : :inactive_account
  end

  def organization_role(organization)
    user_organizations.find_by(organization: organization).role
  end

  def organization_admin?(organization)
    organization_role(organization) == 'admin'
  end

  def organization_staff?(organization)
    organization_role(organization) == 'staff'
  end
end
