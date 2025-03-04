class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy info]
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    @customers = Customer.where(organization: organization)

    if params[:query].present?
      @customers = @customers.where("name LIKE ? OR phone_number LIKE ? OR alternate_phone_number LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
    end
    @customers = @customers.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
    @customer.build_billing_address(address_type: :billing) if @customer.billing_address.nil?
    @customer.build_delivery_address(address_type: :delivery) if @customer.delivery_address.nil?
  end

  def new
    @customer = Customer.new

    respond_to do |format|
      format.js { render partial: "form", locals: { customer: @customer, is_remote: true } }
      format.html
    end
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        @customer.update(organization: organization)
        format.js # Renders `create.js.erb`
        format.html { redirect_to @customer, notice: "Customer was successfully created." }
      else
        format.js { render :new } # Renders `new.js.erb` with errors
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: "Customer was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to customers_url, notice: "Customer was successfully destroyed."
  end

  def search
    customers = Customer.where(organization: organization).where("name iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { customers: customers.map { |customer| { id: customer.id, name: "#{customer.name}"  } } }
  end

  # def info
  #   render json: @customer
  # end

  def info
    customer = Customer.includes(:billing_address, :delivery_address).find(params[:id])
    render json: customer.as_json(
      include: {
        billing_address: { methods: [ :full_address ] },
        delivery_address: { methods: [ :full_address ] }
      }
    )
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :owner_name, :email, :phone_number, :alternate_phone_number, :gst_detail, :pan_number,
      billing_address_attributes: [ :id, :address, :city, :pincode, :state_id, :country_id, :address_type, :_destroy ],
      delivery_address_attributes: [ :id, :address, :city, :pincode, :state_id, :country_id, :address_type, :_destroy ]
    )
  end
end
