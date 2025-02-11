class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy info]
  before_action :authenticate_user!
  before_action :check_admin_role

  def index
    if params[:query].present?
      @users = User.where("name LIKE ? OR email LIKE ? ", "%#{params[:query]}%", "%#{params[:query]}%").where.not(role: 'super_admin')
    else
      @users = User.where.not(role: 'super_admin')
    end

    @users = @users.order(created_at: :desc).page(params[:page]).per(10) # Paginate results
  end

  def show
  end

  def new
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  def search
    users = User.where("name iLIKE ?", "%#{params[:q]}%").first(5)

    render json: { users: users.map { |user| { id: user.id, name: "#{user.name}"  } } }
  end


  def info
    render json: @user
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role, :is_active)
  end
end
