class PrescriptionsController < ApplicationController
  def new
    @prescription = Prescription.new
    respond_to do |format|
      format.js {render partial: 'new', locals: {prescription: @prescription, params: params }}
      format.html
    end
  end

  def create
    @prescription = Prescription.new(prescription_params)
    @prescription.save
    redirect_to patient_follow_ups_path(@prescription.follow_up.patient)
  end

  def edit
    @prescription = Prescription.find(params[:id])
    respond_to do |format|
      format.js {render partial: 'edit', locals: {prescription: @prescription, params: params }}
      format.html
    end
  end

  def update
    @prescription = Prescription.find(params[:id])
    @prescription.update(prescription_params)
    redirect_to patient_follow_ups_path(@prescription.follow_up.patient)
  end

  def destroy
    @prescription = Prescription.find(params[:id])
    @patient = @prescription.follow_up.patient
    @prescription.destroy
    redirect_to patient_follow_ups_path(@prescription.follow_up.patient), notice: 'Patient was successfully destroyed.'
  end

  def search_medicines
    medicines = Medicine.where("name iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { medicines: medicines.map { |medicine| { id: medicine.id, name: medicine.name } } }
  end


  private

  def prescription_params
    params.require(:prescription).permit(:appointment_id, :follow_up_id, :medicine_id, :dosage, :note)
  end

end

