class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy info suppliers_list purchase_invoices_list job_invoices_list]
  before_action :check_admin_staff_role
  before_action :authenticate_user!


  # GET /products
  def index
    @products = organization.products
    if params[:query].present?
      @products = @products.where("name LIKE ?", "%#{params[:query]}%")
    end

    @products = @products.page(params[:page]).per(10) # Paginate results
  end

  # GET /products/:id
  def show
    @inventories = fetch_inventory_data(@product.id)
  end

  # GET /products/new
  def new
    @product = Product.new
    respond_to do |format|
      format.js { render partial: "form", locals: { product: @product, is_remote: true } }
      format.html
    end
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        @product.update(organization: organization)
        format.js # Renders `create.js.erb`
        format.html { redirect_to @product, notice: "Product was successfully created." }
      else
        format.js { render :new } # Renders `new.js.erb` with errors
        format.html { render :new }
      end
    end
  end

  # GET /products/:id/edit
  def edit
  end

  # PATCH/PUT /products/:id
  def update
    if @product.update(product_params)
      redirect_to @product, notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def search
    products = Product.where(organization: organization).where("name iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { products: products.map { |products| { id: products.id, name: products.name } } }
  end

  # DELETE /products/:id
  def destroy
    @product.destroy
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  def info
    product = Product.includes(:hsn).find(params[:id])
    render json: product.as_json(include: :hsn)
  end

  def suppliers_list
    suppliers = @product.suppliers.distinct
    render json: { suppliers: suppliers.map { |supplier| { id: supplier.id, name: "#{supplier.name}"  } } }
  end

  def purchase_invoices_list
    purchase_invoices = @product.purchase_invoices.distinct
    render json: { invoices: purchase_invoices.map { |p_invoice| { id: p_invoice.purchase_inventories.find_by(product: @product).id, bill_no: "#{p_invoice&.supplier&.name} - #{p_invoice.bill_no}" } } }
  end

  def job_invoices_list
    job_invoices = @product.job_invoices.distinct
    render json: { invoices: job_invoices.map { |j_invoice| { id: j_invoice.job_inventories.find_by(product: @product).id, bill_no: "#{j_invoice&.customer&.name} - #{j_invoice.bill_no}" } } }
  end

  def sales_invoices_list
    sales_invoices = @product.sales_invoices.distinct
    render json: { invoices: sales_invoices.map { |s_invoice| { id: s_invoice.sales_inventories.find_by(product: @product).id, bill_no: "#{s_invoice&.customer&.name || s_invoice&.supplier&.name} - #{s_invoice.bill_no}" } } }
  end

  private

  # Set the product for actions like show, edit, update, and destroy
  def set_product
    @product = organization.products.find_by(id: params[:id])
  end

  # Only allow a list of trusted parameters through
  def product_params
    params.require(:product).permit(:name, :description, :hsn_id, :price, :barcode)
  end

  def fetch_inventory_data(product_id)
    sales = SalesInventory.joins([ sales_invoice: :customer ], :product)
                          .where(sales_inventories: { product_id: product_id })
                          .select("'sales' AS inventory_type, customers.name AS party_name, sales_invoices.date, sales_inventories.quantity, products.name AS product_name, sales_invoices.bill_no, sales_inventories.created_at")

    purchases = PurchaseInventory.joins([ purchase_invoice: :supplier ], :product)
                                 .where(purchase_inventories: { product_id: product_id })
                                 .select("'purchase' AS inventory_type, suppliers.name AS party_name, purchase_invoices.date, purchase_inventories.quantity, products.name AS product_name, purchase_invoices.bill_no, purchase_inventories.created_at")

    jobs = JobInventory.joins([ job_invoice: :customer ], :product)
                       .where(job_inventories: { product_id: product_id })
                       .select("'job' AS inventory_type, customers.name AS party_name, job_invoices.date, job_inventories.quantity, products.name AS product_name, job_invoices.bill_no, job_inventories.created_at")

    sales_returns = SalesReturnInventory.joins([ sales_return_invoice: :customer ], :product)
                                            .where(sales_return_inventories: { product_id: product_id })
                                            .select("'sales_return' AS inventory_type, customers.name AS party_name, sales_return_invoices.date, sales_return_inventories.quantity, products.name AS product_name, sales_return_invoices.bill_no, sales_return_inventories.created_at")

    purchase_returns = PurchaseReturnInventory.joins([ purchase_return_invoice: :supplier ], :product)
                                 .where(purchase_return_inventories: { product_id: product_id })
                                 .select("'purchase_return' AS inventory_type, suppliers.name AS party_name, purchase_return_invoices.date, purchase_return_inventories.quantity, products.name AS product_name, purchase_return_invoices.bill_no, purchase_return_inventories.created_at")

    sales_sql = sales.to_sql
    purchases_sql = purchases.to_sql
    sales_returns_sql = sales_returns.to_sql
    purchase_returns_sql = purchase_returns.to_sql

    jobs_sql = jobs.to_sql

    combined_sql = "(#{sales_sql}) UNION ALL (#{purchases_sql}) UNION ALL (#{jobs_sql}) UNION ALL (#{sales_returns_sql}) UNION ALL (#{purchase_returns_sql}) ORDER BY date ASC, created_at ASC"
    ActiveRecord::Base.connection.execute(combined_sql)
  end
end
