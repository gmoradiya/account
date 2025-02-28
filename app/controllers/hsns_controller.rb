class HsnsController < ApplicationController
  before_action :set_hsn, only: %i[show edit update destroy]
  before_action :authenticate_user!
  before_action :check_admin_staff_role

  # GET /hsns
  def index
    @hsns = Hsn.all
    if params[:query].present?
      @hsns = @hsns.where("code LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    @hsns = @hsns.page(params[:page]).per(10)
  end

  # GET /hsns/:id
  def show
  end

  # GET /hsns/new
  def new
    @hsn = Hsn.new
  end

  # POST /hsns
  def create
    @hsn = Hsn.new(hsn_params)

    if @hsn.save
      redirect_to @hsn, notice: "Hsn was successfully created."
    else
      render :new
    end
  end

  # GET /hsns/:id/edit
  def edit
  end

  # PATCH/PUT /hsns/:id
  def update
    if @hsn.update(hsn_params)
      redirect_to @hsn, notice: "Hsn was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /hsns/:id
  def destroy
    @hsn.destroy
    redirect_to hsns_url, notice: "Hsn was successfully destroyed."
  end

  def search
    hsns = Hsn.all.where("code iLIKE ? or description iLIKE ? ", "%#{params[:q]}%", "%#{params[:q]}%").first(5)
    render json: { hsns: hsns.map { |hsn| { id: hsn.id, name: "#{hsn.code} - #{hsn.description}  (#{hsn.gst} %)"  } } }
  end

  private

  # Set the hsn for actions like show, edit, update, and destroy
  def set_hsn
    @hsn = Hsn.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def hsn_params
    params.require(:hsn).permit(:schedule, :s_no, :code, :description, :sgst, :cgst, :gst)
  end
end
