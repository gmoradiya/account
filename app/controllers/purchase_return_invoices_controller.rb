class PurchaseReturnInvoicesController < ApplicationController
  before_action :set_purchase_return_invoice, only: [ :edit, :update, :show, :info ]
  before_action :authenticate_user!

  def index
    start_date, end_date = financial_year_range
    @purchase_return_invoices = organization.purchase_return_invoices.by_financial_year(start_date, end_date).page(params[:page]).per(10)

    if params[:query].present?
      @purchase_return_invoices = @purchase_return_invoices.where("bill_no LIKE ?", "%#{params[:query]}%")
    end
    purchase_return_invoices = @purchase_return_invoices
    @purchase_return_invoices = @purchase_return_invoices.page(params[:page]).per(10) # Paginate results
    respond_to do |format|
      format.json { render json: { invoices: purchase_return_invoices.map { |p_invoice| { id: p_invoice.id, bill_no: "#{p_invoice&.supplier&.name} - #{p_invoice.bill_no}" } } } }
      format.html
      format.csv do
        send_data generate_csv(purchase_return_invoices), filename: "purchase_return_invoices_#{Date.today}.csv"
      end
    end
  end

  def new
    @purchase_return_invoice = PurchaseReturnInvoice.new
    @purchase_return_invoice.purchase_return_inventories.build
  end

  def create
    @purchase_return_invoice = PurchaseReturnInvoice.new(purchase_return_invoice_params)
    @purchase_return_invoice.supplier = @purchase_return_invoice.purchase_invoice.supplier

    if @purchase_return_invoice.save
      @purchase_return_invoice.update(total: @purchase_return_invoice.purchase_return_inventories.map { |i| i.price * i.quantity }.sum,
        cgst: @purchase_return_invoice.purchase_return_inventories.sum(&:cgst),
        sgst: @purchase_return_invoice.purchase_return_inventories.sum(&:sgst),
        discount: @purchase_return_invoice.purchase_return_inventories.sum(&:discount),
        grand_total: @purchase_return_invoice.purchase_return_inventories.sum(&:sub_total),
        organization: organization
      )
      redirect_to @purchase_return_invoice, notice: "Invoice created successfully!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @purchase_return_invoice.update(purchase_return_invoice_params)
      @purchase_return_invoice.update(total: @purchase_return_invoice.purchase_return_inventories.map { |i| i.price * i.quantity }.sum,
        cgst: @purchase_return_invoice.purchase_return_inventories.sum(&:cgst),
        sgst: @purchase_return_invoice.purchase_return_inventories.sum(&:sgst),
        discount: @purchase_return_invoice.purchase_return_inventories.sum(&:discount),
        grand_total: @purchase_return_invoice.purchase_return_inventories.sum(&:sub_total),
        organization: organization
      )
      redirect_to @purchase_return_invoice, notice: "Purchase Invoice was successfully updated."
    else
      render :edit
    end
  end

  def info
    render json: @purchase_return_invoice
  end

  def search
    purchase_return_invoices = organization.purchase_return_invoices.where("bill_no iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { invoices: purchase_return_invoices.map { |p_invoice| { id: p_invoice.id, bill_no: "#{p_invoice&.supplier&.name} - #{p_invoice.bill_no}" } } }
  end


  private

  def set_purchase_return_invoice
    @purchase_return_invoice = organization.purchase_return_invoices.where(payment_status: [ :pending, :partially_paid ]).find_by(id: params[:id])
  end

  def purchase_return_invoice_params
    params.require(:purchase_return_invoice).permit(:bill_no, :purchase_invoice_id, :date, :total, :cgst, :sgst, :discount, :grand_total,
                                          purchase_return_inventories_attributes: [ :id, :product_id, :price, :total, :quantity, :cgst_percentage, :cgst, :sgst_percentage, :sgst, :discount_percentage, :discount, :sub_total, :_destroy ])
  end

  def generate_csv(purchase_return_invoices)
    CSV.generate(headers: true) do |csv|
      csv << [ "S.No.", "Return Invoice Number" "Invoice Nmber", "Date", "Supplier Name", "Total Amount", "Received_amount", "Remaining Amount", "Status" ] # Headers

      purchase_return_invoices.each_with_index do |invoice, ind|
        csv << [
          ind +1,
          invoice.bill_no,
          invoice.purchase_invoice.bill_no,
          invoice.date,
          invoice&.invoice&.supplier&.name,
          invoice.grand_total,
          invoice.received_amount,
          invoice.grand_total - invoice.received_amount,
          invoice.payment_status
        ]
      end
    end
  end
end
