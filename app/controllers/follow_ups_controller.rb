class FollowUpsController < ApplicationController
  before_action :set_patient
  before_action :authenticate_user!

  def index
    @follow_ups = @patient.follow_ups.order(created_at: :desc).page(params[:page]).per(12) # Get all drawings (PDFs) for the user 
  end

  def new
    @appointment = @patient.appointments.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day).last
    if @appointment.blank?
      @appointment = @patient.appointments.create(patient_name: @patient.name, date: Date.today, phone_number: @patient.phone_number, appointment_type: Appointment.appointment_types[:homeopathy])
    end
    @follow_up = @patient.follow_ups.new # Create a new drawing for the user
  end

  def create
    @follow_up = @patient.follow_ups.new(follow_up_params)
    if params[:follow_up][:pdf].present?
      # Save the PDF attached to the drawing
      @follow_up.pdf.attach(params[:follow_up][:pdf])
  
      if @follow_up.save
        redirect_to patient_path(@patient), notice: 'followup was successfully created.'
      else
        render json: { errors: @follow_up.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'No PDF found in request.' }, status: :unprocessable_entity
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:patient_id]) # Find the user by ID
  end

  def follow_up_params
    params.require(:follow_up).permit(:pdf, :appointment_id) # Only allow PDF upload
  end
end


