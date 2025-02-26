class SuppliersController < ApplicationController
  before_action :set_supplier, only: %i[show edit update destroy info]
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    @suppliers = organization.suppliers
    if params[:query].present?
      @suppliers = @suppliers.where("name LIKE ? OR phone_number LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    @suppliers = @suppliers.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
  end

  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.js { render partial: "form", locals: { supplier: @supplier, is_remote: true } }
      format.html
    end
  end

  def create
    @supplier = Supplier.new(supplier_params)
    respond_to do |format|
      if @supplier.save
        @supplier.update(organization: organization)
        format.js # Renders `create.js.erb`
        format.html { redirect_to @supplier, notice: "Supplier was successfully created." }
      else
        format.js { render :new } # Renders `new.js.erb` with errors
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @supplier.update(supplier_params)
      redirect_to @supplier, notice: "Supplier was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @supplier.destroy
    redirect_to suppliers_url, notice: "Supplier was successfully destroyed."
  end

  def search
    suppliers = organization.suppliers.where("name iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { suppliers: suppliers.map { |supplier| { id: supplier.id, name: "#{supplier.name}"  } } }
  end

  def info
    render json: @supplier
  end

  private

  def set_supplier
    @supplier = organization.suppliers.find_by(id: params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:name, :owner_name, :email, :phone_number, :alternate_phone_number, :gst_detail, :pan_number)
  end
end
