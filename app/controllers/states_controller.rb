class StatesController < ApplicationController
  before_action :check_admin_staff_role
  before_action :authenticate_user!

  def index
    if params[:query].present?
      @states = State.where("name LIKE ? OR code LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @states = State.all
    end

    @states = @states.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def new
    @state = State.new
    respond_to do |format|
      format.js { render partial: "new", locals: { state: @state, params: params } }
      format.html
    end
  end

  def show
    @state = State.find(params[:id])
  end

  def create
    @state = State.new(state_params)
    @state.save
    redirect_to states_path(@state)
  end

  def edit
    @state = State.find(params[:id])
    respond_to do |format|
      format.js { render partial: "edit", locals: { state: @state, params: params } }
      format.html
    end
  end

  def update
    @state = State.find(params[:id])
    @state.update(state_params)
    redirect_to states_path(@state)
  end

  def destroy
    @state = State.find(params[:id])
    @state.destroy
    redirect_to states_path(@state), notice: "States was successfully destroyed."
  end

  private

  def state_params
    params.require(:state).permit(:appointment_id, :follow_up_id, :medicine_id, :dosage, :note)
  end
end
