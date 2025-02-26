class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy info]
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    start_date, end_date = financial_year_range
    @payments = organization.payments.by_financial_year(start_date, end_date)
    @amount = @payments.group(:billable_type).sum(:amount)

    if params[:query].present?
      @payments = @payments.where("bill_no LIKE ? ", "%#{params[:query]}%")
    end
    @payments = @payments.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      @payment.update(organization: organization)

      redirect_to @payment, notice: "Payment was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to @payment, notice: "Payment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to payments_url, notice: "Payment was successfully destroyed."
  end

  def search
    payments = organization.payments.where("name iLIKE ?", "%#{params[:q]}%").first(5)
    render json: { payments: payments.map { |payment| { id: payment.id, name: "#{payment.name}"  } } }
  end

  def info
    render json: @payment
  end

  private

  def set_payment
    @payment = organization.payments.find_by(id: params[:id])
  end

  def payment_params
    params.require(:payment).permit(:billable_id, :billable_type, :amount, :date, :payment_detail, :payment_type)
  end
end
