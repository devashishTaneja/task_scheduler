class LoginController < ApplicationController
	def index
	end

	def login
		user = User.find_by_email(user_params[:email])
		if(user && user.authenticate(user_params[:password]))
			flash[:info] = 'Logged in successfully'
			session[:user_id] = user.id
			redirect_to root_path
		else
			flash[:alert] = 'Incorrect UserID or Password'
			render action: 'index'
		end   
	end

	def user_params
		params.require(:user).permit(:email, :password)
	end

	def logout
		@current_user = nil
		session.delete(:user_id)
		flash[:info] = 'Logged out successfully'
		redirect_to root_path
	end
end
