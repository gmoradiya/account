class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show edit update destroy info invite_user remove_user]
  before_action :authenticate_user!, except: [ :accept_invitation ]
  before_action :check_admin_role, except: [ :index, :show, :accept_invitation, :create, :new ]

  def index
    @organizations = current_user.organizations

    if params[:query].present?
      @organizations = @organizations.where("name LIKE ? OR phone_number LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%")
    end
    @organizations = @organizations.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
  end

  def new
    @organization = current_user.organizations.new
  end

  def create
    if current_user.organizations.count == 2
      return redirect_to organizations_path, alert: "Organization Creation limits."
    end
    @organization = current_user.organizations.new(organization_params)
    if @organization.save
      current_user.user_organizations.create(organization: @organization, role: "admin")
      redirect_to @organization, notice: "Organization was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: "Organization was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_url, notice: "Organization was successfully destroyed."
  end

  # def invite_user
  #   email = params[:email].downcase.strip
  #   user = User.find_by(email: email)

  #   if user
  #     # If user exists, add them to the organization
  #     unless @organization.users.include?(user)
  #       @organization.users << user
  #       flash[:notice] = "#{user.name} has been added to the organization."
  #     else
  #       flash[:alert] = "User is already part of the organization."
  #     end
  #   else
  #     # If user doesn't exist, create an invitation
  #     invitation = @organization.invitations.create(email: email, accepted: false)
  #     InvitationMailer.send_invite(invitation).deliver_now
  #     flash[:notice] = "Invitation sent to #{email}."
  #   end

  #   redirect_to @organization
  # end

  def invite_user
    email = params[:email].downcase.strip
    user = User.find_by(email: email)

    if user
      if @organization.users.include?(user)
        flash[:alert] = "User is already part of the organization."
      else
        @organization.users << user
        InvitationMailer.existing_user_invite(user, @organization).deliver_now
        flash[:notice] = "#{user.email} has been added, and they were notified by email."
      end
    else
      invitation = @organization.invitations.create(email: email, accepted: false)
      InvitationMailer.new_user_invite(invitation).deliver_now
      flash[:notice] = "Invitation sent to #{email}."
    end

    redirect_to @organization
  end

  # app/controllers/organizations_controller.rb
  def accept_invitation
    invitation = Invitation.find_by(token: params[:token])

    if invitation && !invitation.accepted
      user = User.find_by(email: invitation.email)

      if user
        invitation.organization.users << user
        flash[:notice] = "You have been added to #{invitation.organization.name}!"
      else
        user = User.new(email: invitation.email)
        user.save(validate: false) # Save without validations to allow empty password
        invitation.organization.users << user

        # Generate reset password token
        user.send_reset_password_instructions

        flash[:notice] = "Account created! Please check your email to set your password."
      end

      invitation.update(accepted: true)
      redirect_to new_user_session_path
    else
      flash[:alert] = "Invalid or expired invitation."
      redirect_to root_path
    end
  end

  def remove_user
    user = User.find(params[:user_id])
    if @organization.users.include?(user)
      @organization.users.delete(user)
      flash[:notice] = "#{user.name} removed from organization."
    else
      flash[:alert] = "User not found in this organization."
    end
    redirect_to @organization
  end

  def search
    organizations = Organization.where("name iLIKE ?", "%#{params[:q]}%").first(5)
    render json: { organizations: organizations.map { |organization| { id: organization.id, name: "#{organization.name}"  } } }
  end

  def info
    render json: @organization
  end

  private

  def set_organization
    @organization = Organization.find(organization.id)
  end

  def organization_params
    params.require(:organization).permit(:name, :full_address, :phone_number, :gst_detail, :bank_name, :account_number, :ifcs_code, :branch, :country_id, :state_id)
  end
end
