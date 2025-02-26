class JobInvoicesController < ApplicationController
  before_action :set_job_invoice, only: [ :edit, :update, :show ]
  before_action :authenticate_user!

  def index
    start_date, end_date = financial_year_range
    @job_invoices = organization.job_invoices.by_financial_year(start_date, end_date).page(params[:page]).per(10)

    if params[:query].present?
      @job_invoices = @job_invoices.where("bill_no LIKE ?", "%#{params[:query]}%")
    end
    job_invoices = @job_invoices.where(payment_status: [ :pending, :partially_paid ])
    @job_invoices = @job_invoices.page(params[:page]).per(10) # Paginate results
    respond_to do |format|
      format.json {
        render json: {
          invoices: job_invoices.map { |j_invoice| { id: j_invoice.id, bill_no: "#{j_invoice&.supplier&.name} - #{j_invoice.bill_no}" } }
        }
      }
      format.html
    end
  end

  def new
    @job_invoice = JobInvoice.new
    @job_invoice.job_inventories.build
  end

  def create
    @job_invoice = JobInvoice.new(job_invoice_params)
    if @job_invoice.save
      @job_invoice.update(organization: organization)
      redirect_to @job_invoice, notice: "Invoice created successfully!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @job_invoice.update(job_invoice_params)
      redirect_to @job_invoice, notice: "Sales Invoice was successfully updated."
    else
      render :edit
    end
  end

  private

  def set_job_invoice
    @job_invoice = organization.job_invoices.find_by(id: params[:id])
  end

  def job_invoice_params
    params.require(:job_invoice).permit(:bill_no, :customer_id, :date, :total,
                                          job_inventories_attributes: [ :id, :product_id, :quantity, :total, :_destroy ])
  end
end
