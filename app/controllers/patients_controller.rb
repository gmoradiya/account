class PatientsController < ApplicationController
  before_action :set_patient, only: %i[show edit update destroy signature new_signature save_signature info]
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @patients = Patient.where("name LIKE ? OR case_number LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @patients = Patient.all
    end
    if params[:patient_type].present?
      @patients = @patients.where(patient_type: params[:patient_type])
    end

    @patients = @patients.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to @patient, notice: 'Patient was successfully created.'
    else
      render :new
    end
  end



  def edit
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy
    redirect_to patients_url, notice: 'Patient was successfully destroyed.'
  end

  def search
    patients = Patient.where("name iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { patients: patients.map { |patient| { id: patient.id, name: "#{patient.name} - #{patient.case_number}"  } } }
  end

  def signature

  end

  def new_signature
    respond_to do |format|
      format.js {render partial: 'new_signature', locals: {patient: @patient, params: params }}
      format.html
    end
  end

  def save_signature
    @patient.signature.attach(params[:patient][:signature])
    @patient.date_of_signature = Date.today

    if @patient.save
      redirect_to signature_patient_path(@patient), notice: 'patient signature was successfully added.'
    else
      render json: { errors: @patient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def info
    render json: @patient
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(:name, :address, :phone_number, :email, :case_number, :date_of_birth, :patient_type, :weight, :reference_by, :occupation, :sex, :chief_complaints, :photo, :signature)
  end
end
