class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource

  def index
    authorize! :manage, :all
    @users = User.all.order(:role)
  end

  def set_user
  end

  def new
    @user = User.new
  end

  def create
    authorize! :manage, :all
    @user = User.create(user_params)
    # @user.role = current_user.role
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was succesfully created.' }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize! :manage, :all   
    @user = User.find(params[:id])
    begin
      @user.destroy
      flash[:notice] = "User #{@user.email} deleted"
    rescue StandardError => e
      flash[:notice] = e.message
    end
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
  end

  def update
    respond_to do |format|
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:role, :email, :password, :password_confirmation)
  end
end
