class CountriesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_staff_role

  def index
    if params[:query].present?
      @countries = Country.where("name LIKE ? OR iso_code LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @countries = Country.all
    end

    @countries = @countries.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def new
    @country = Country.new
    respond_to do |format|
      format.js { render partial: "new", locals: { country: @country, params: params } }
      format.html
    end
  end

  def create
    @country = Country.new(country_params)
    @country.save
    redirect_to country_path(@country)
  end

  def edit
    @country = Country.find(params[:id])
    respond_to do |format|
      format.js { render partial: "edit", locals: { country: @country, params: params } }
      format.html
    end
  end

  def show
    @country = Country.find(params[:id])
  end

  def update
    @country = Country.find(params[:id])
    @country.update(country_params)
    redirect_to country_path(@country)
  end

  def destroy
    @country = Country.find(params[:id])
    @country.destroy
    redirect_to countries_path, notice: "Country was successfully destroyed."
  end

  private

  def country_params
    params.require(:country).permit(:name, :iso_code)
  end
end
