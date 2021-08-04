class UsersController < ApplicationController
	def index
		@user = current_user
		if @user
			@active_tasks = current_user.tasks.active_tasks
			@expired_tasks = current_user.tasks.expired_task
		end
		@users = User.all
	end

	def new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to root_url
		else
			flash[:error] = @user.errors.full_messages.to_sentence
			render 'new'
		end	
	end
	
	def show
		@user = User.find_by_id(params[:id])
		if(@user)
			@active_tasks = @user.tasks.active_tasks
			@expired_tasks = @user.tasks.expired_task
		end
	end

	def delete
		@user = User.find_by_id(params[:id])
		if @user.destroy
			flash[:success] = "User deleted successfully"
			redirect_to root_url
		else
			flash[:error] = @task.errors.full_messages.to_sentence
			redirect_to delete_user_url(@task)
		end
	end

	def user_params
		params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
	end
end
