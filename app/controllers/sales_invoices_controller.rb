class SalesInvoicesController < ApplicationController
  before_action :set_sales_invoice, only: [ :edit, :update, :show, :info ]
  before_action :authenticate_user!
  require "csv"  # Ensure CSV library is included

  def index
    start_date, end_date = financial_year_range
    @sales_invoices = organization.sales_invoices.by_financial_year(start_date, end_date).page(params[:page]).per(10)

    if params[:query].present?
      @sales_invoices = @sales_invoices.where("bill_no LIKE ?", "%#{params[:query]}%")
    end
    sales_invoices = @sales_invoices # .where(payment_status: [:pending, :partially_paid])
    @sales_invoices = @sales_invoices.page(params[:page]).per(10) # Paginate results
    respond_to do |format|
      format.json { render json: { invoices: sales_invoices.map { |s_invoice| { id: s_invoice.id, bill_no: "#{s_invoice&.customer&.name || s_invoice&.supplier&.name} - #{s_invoice.bill_no}" } } } }
      format.html
      format.csv do
        send_data generate_csv(sales_invoices), filename: "sales_invoices_#{Date.today}.csv"
      end
    end
  end

  def new
    @sales_invoice = SalesInvoice.new
    @sales_invoice.sales_inventories.build
  end

  def create
    @sales_invoice = SalesInvoice.new(sales_invoice_params)
    if @sales_invoice.save
      @sales_invoice.update(total: @sales_invoice.sales_inventories.map { |i| i.price * i.quantity }.sum,
        cgst: @sales_invoice.sales_inventories.sum(&:cgst),
        sgst: @sales_invoice.sales_inventories.sum(&:sgst),
        discount: @sales_invoice.sales_inventories.sum(&:discount),
        grand_total: @sales_invoice.sales_inventories.sum(&:sub_total),
        organization: organization
      )
      redirect_to @sales_invoice, notice: "Invoice created successfully!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @sales_invoice.update(sales_invoice_params)
      @sales_invoice.update(total: @sales_invoice.sales_inventories.map { |i| i.price * i.quantity }.sum,
        cgst: @sales_invoice.sales_inventories.sum(&:cgst),
        sgst: @sales_invoice.sales_inventories.sum(&:sgst),
        discount: @sales_invoice.sales_inventories.sum(&:discount),
        grand_total: @sales_invoice.sales_inventories.sum(&:sub_total),
        organization: organization
      )
      redirect_to @sales_invoice, notice: "Sales Invoice was successfully updated."
    else
      render :edit
    end
  end


  def search
    sales_invoices = organization.sales_invoices.where("bill_no iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { invoices: sales_invoices.map { |s_invoice| { id: s_invoice.id, bill_no: "#{s_invoice&.customer&.name || s_invoice&.supplier&.name} - #{s_invoice.bill_no}" } } }
  end


  def info
    render json: @sales_invoice
  end

  private

  def set_sales_invoice
    @sales_invoice = organization.sales_invoices.find_by(id: params[:id])
  end

  def sales_invoice_params
    params.require(:sales_invoice).permit(:bill_no, :customer_id, :date, :total, :cgst, :sgst, :discount, :grand_total, :delivery_address, :billing_address, :bill_type,
                                          sales_inventories_attributes: [ :id, :product_id, :price, :total, :quantity, :cgst_percentage, :cgst, :sgst_percentage, :sgst, :discount_percentage, :discount, :sub_total, :invoiceable_id, :invoiceable_type, :_destroy ])
  end

  def generate_csv(sales_invoices)
    CSV.generate(headers: true) do |csv|
      csv << [ "S.No.", "Invoice Nmber", "Date", "Customer Name", "Total Amount", "Received_amount", "Remaining Amount", "Status" ]  # Headers

      sales_invoices.each_with_index do |invoice, ind|
        csv << [
          ind +1,
          invoice.bill_no,
          invoice.date,
          invoice&.customer&.name,
          invoice.grand_total,
          invoice.received_amount,
          invoice.grand_total - invoice.received_amount,
          invoice.payment_status
        ]
      end
    end
  end
end
