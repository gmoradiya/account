class OrganizationsController < ApplicationController
  before_action :set_organization, only: %i[show edit update destroy info]
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    if params[:query].present?
      @organizations = Organization.where("name LIKE ? OR phone_number LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%").where.not(role: "super_admin")
    else
      @organizations = Organization.where.not(role: "super_admin")
    end
    @organizations = @organizations.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create_organization
    @organization = Organization.new(organization_params)
    if @organization.save
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
    params.require(:organization).permit(:name, :full_address, :phone_number, :gst_detail, :bank_name, :account_number, :ifcs_code, :branch)
  end
end
