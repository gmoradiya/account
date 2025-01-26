class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  skip_forgery_protection only: [:prescriptions]

  def index
    @appointments = Appointment.where(appointment_status: 0)
  end

  def show
  end

  def edit
  end

  def new
    if params[:patient_id].present?
      @patient = Patient.find(params[:patient_id]) 
      @appointment = @patient.appointments.new(date: DateTime.now, patient_name: @patient.name, phone_number: @patient.phone_number)
    else
      @appointment = Appointment.new
    end

    respond_to do |format|
      format.js {render partial: 'new', locals: {appointment: @appointment, patient: @patient }}

      format.html
    end

  end

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.save
    redirect_to root_path
  end

  def change_status
    @appointment = Appointment.find(params[:id])
    @appointment.update(appointment_status: params[:appointment_status].to_i)
    redirect_to root_path
  end

  def prescriptions
    @appointment = Appointment.find(params[:id])
    @prescriptions = @appointment.prescriptions
    # respond_to do |format|
    #   format.js  # Rails will look for a prescriptions.js.erb file
    # end

    render partial: 'prescriptions/prescriptions', locals: { prescriptions: @prescriptions, appointment: @appointment }

  end

  private

  def appointment_params
    params.require(:appointment).permit(:patient_id, :patient_name, :date, :phone_number, :appointment_type)
  end


end
