class DisplaysController < ApplicationController
  before_action :authenticate_user!

  def index
    start_date, end_date = financial_year_range
    @payments = Payment.where(organization: organization).by_financial_year(start_date, end_date)
    @amount = @payments.group(:billable_type).sum(:amount)

    @purchase_invoices = PurchaseInvoice.where(organization: organization).by_financial_year(start_date, end_date)
    @sales_invoices = SalesInvoice.where(organization: organization).by_financial_year(start_date, end_date)
    @purchase_return_invoices = PurchaseReturnInvoice.where(organization: organization).by_financial_year(start_date, end_date)
    @sales_return_invoices = SalesReturnInvoice.where(organization: organization).by_financial_year(start_date, end_date)

    @gross_sales = @sales_invoices.sum(:grand_total)
    @gross_purchase = @purchase_invoices.sum(:grand_total)
    @gross_sales_return = @sales_return_invoices.sum(:grand_total)
    @gross_purchase_return = @purchase_return_invoices.sum(:grand_total)

    @gst_paid = (@purchase_invoices.sum(:cgst) +  @purchase_invoices.sum(:sgst)) - (@purchase_return_invoices.sum(:cgst) +  @purchase_return_invoices.sum(:sgst))
    @gst_received = (@sales_invoices.sum(:cgst) + @sales_invoices.sum(:sgst)) - (@sales_return_invoices.sum(:cgst) + @sales_return_invoices.sum(:sgst))
    @pending_invitations = Invitation.where(email: current_user.email, accepted: false)

    # start_time = Date.today.beginning_of_day
    # end_time =  Date.today.end_of_day
    # if params[:date].present?
    #   start_time = Date.parse(params[:date]).beginning_of_day
    #   end_time = Date.parse(params[:date]).end_of_day
    # end
    # @users = Appointment.where("date >= ? and date <= ?" , start_time, end_time).order(created_at: :asc)
  end

  def manage_organization
    @organization = organization
  end
end
