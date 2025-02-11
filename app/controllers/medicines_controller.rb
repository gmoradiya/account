class MedicinesController < ApplicationController
  before_action :set_medicine, only: %i[show edit update destroy]
  before_action :check_admin_staff_role

  # GET /medicines
  def index
    @medicines = Medicine.all
    if params[:query].present?
      @medicines = Medicine.where("name LIKE ?", "%#{params[:query]}%")
    else
      @medicines = Medicine.all
    end

    @medicines = @medicines.page(params[:page]).per(10) # Paginate results
  end

  # GET /medicines/:id
  def show
  end

  # GET /medicines/new
  def new
    @medicine = Medicine.new
  end

  # POST /medicines
  def create
    @medicine = Medicine.new(medicine_params)

    if @medicine.save
      redirect_to @medicine, notice: 'Medicine was successfully created.'
    else
      render :new
    end
  end

  # GET /medicines/:id/edit
  def edit
  end

  # PATCH/PUT /medicines/:id
  def update
    if @medicine.update(medicine_params)
      redirect_to @medicine, notice: 'Medicine was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /medicines/:id
  def destroy
    @medicine.destroy
    redirect_to medicines_url, notice: 'Medicine was successfully destroyed.'
  end

  private

  # Set the medicine for actions like show, edit, update, and destroy
  def set_medicine
    @medicine = Medicine.find(params[:id])
  end

  # Only allow a list of trusted parameters through
  def medicine_params
    params.require(:medicine).permit(:name, :dosage, :description)
  end
end
