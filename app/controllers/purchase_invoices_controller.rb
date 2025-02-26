class PurchaseInvoicesController < ApplicationController
  before_action :set_purchase_invoice, only: [ :edit, :update, :show, :info ]
  before_action :authenticate_user!

  def index
    start_date, end_date = financial_year_range
    @purchase_invoices = organization.purchase_invoices.by_financial_year(start_date, end_date).page(params[:page]).per(10)

    if params[:query].present?
      @purchase_invoices = @purchase_invoices.where("bill_no LIKE ?", "%#{params[:query]}%")
    end
    purchase_invoices = @purchase_invoices
    @purchase_invoices = @purchase_invoices.page(params[:page]).per(10) # Paginate results
    respond_to do |format|
      format.html
      format.csv do
        send_data generate_csv(purchase_invoices), filename: "purchase_invoices_#{Date.today}.csv"
      end
    end
  end

  def new
    @purchase_invoice = PurchaseInvoice.new
    @purchase_invoice.purchase_inventories.build
  end

  def create
    @purchase_invoice = PurchaseInvoice.new(purchase_invoice_params)
    if @purchase_invoice.save
      @purchase_invoice.update(total: @purchase_invoice.purchase_inventories.map { |i| i.price * i.quantity }.sum,
        cgst: @purchase_invoice.purchase_inventories.sum(&:cgst),
        sgst: @purchase_invoice.purchase_inventories.sum(&:sgst),
        discount: @purchase_invoice.purchase_inventories.sum(&:discount),
        grand_total: @purchase_invoice.purchase_inventories.sum(&:sub_total),
        organization: organization
      )
      redirect_to @purchase_invoice, notice: "Invoice created successfully!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @purchase_invoice.update(purchase_invoice_params)
      @purchase_invoice.update(total: @purchase_invoice.purchase_inventories.map { |i| i.price * i.quantity }.sum,
        cgst: @purchase_invoice.purchase_inventories.sum(&:cgst),
        sgst: @purchase_invoice.purchase_inventories.sum(&:sgst),
        discount: @purchase_invoice.purchase_inventories.sum(&:discount),
        grand_total: @purchase_invoice.purchase_inventories.sum(&:sub_total),
        organization: organization
      )
      redirect_to @purchase_invoice, notice: "Purchase Invoice was successfully updated."
    else
      render :edit
    end
  end

  def info
    render json: @purchase_invoice
  end

  def search
    purchase_invoices = organization.purchase_invoices.where(payment_status: [ :pending, :partially_paid ]).where("bill_no iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { invoices: purchase_invoices.map { |p_invoice| { id: p_invoice.id, bill_no: "#{p_invoice&.supplier&.name} - #{p_invoice.bill_no}" } } }
  end


  private

  def set_purchase_invoice
    @purchase_invoice = organization.purchase_invoices.find_by(id: params[:id])
  end

  def purchase_invoice_params
    params.require(:purchase_invoice).permit(:bill_no, :supplier_id, :date, :total, :cgst, :sgst, :discount, :grand_total,
                                          purchase_inventories_attributes: [ :id, :product_id, :price, :total, :quantity, :cgst_percentage, :cgst, :sgst_percentage, :sgst, :discount_percentage, :discount, :sub_total, :_destroy ])
  end

  def generate_csv(purchase_invoices)
    CSV.generate(headers: true) do |csv|
      csv << [ "S.No.", "Invoice Nmber", "Date", "Supplier Name", "Total Amount", "Received_amount", "Remaining Amount", "Status" ] # Headers

      purchase_invoices.each_with_index do |invoice, ind|
        csv << [
          ind +1,
          invoice.bill_no,
          invoice.date,
          invoice&.supplier&.name,
          invoice.grand_total,
          invoice.paid_amount,
          invoice.grand_total - invoice.paid_amount.to_f,
          invoice.payment_status
        ]
      end
    end
  end
end
