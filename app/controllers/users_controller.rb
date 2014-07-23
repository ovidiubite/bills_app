class UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
load_and_authorize_resource

def index
end


def set_user
end

def new
	@user = User.new
end

def create 

	@user = User.new(user_params)
	# @user.role = current_user.role
	respond_to do |format|
		if @user.save
			format.html { redirect_to users_path, notice: 'User was succsesfully created.'}
		else
			format.html { render action: 'new' }
			format.json { render json: @user.errors, status: :unprocessable_entity }
		end
	end
end


def destroy
	@user.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { head :no_content }
    end
end

def user_params
	params.require(:user).permit(:role, :email, :password, :password_confirmation)
end

end
