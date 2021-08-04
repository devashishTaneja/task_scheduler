class TasksController < ApplicationController

	def show
		@task = Task.find_by_id(params[:id])
	end

	def edit
		@task = Task.find_by_id(params[:id])
	end
	
	def create
		@task = Task.new(task_params)
		if @task.save
			redirect_to show_task_url(@task)
		else
			flash[:error] = @task.errors.full_messages.to_sentence
			redirect_to new_task_url(@task)
		end
	end

	def update
		@task = Task.find_by_id(params[:id])
		@task.update(task_params)
		if @task.save
			redirect_to show_task_url(@task)
		else
			flash[:error] = @task.errors.full_messages.to_sentence
			redirect_to edit_task_url(@task)
		end
	end


	def delete
		@task = Task.find_by_id(params[:id])
		if @task.destroy
			flash[:success] = "Task deleted successfully"
			redirect_to root_url
		else
			flash[:error] = @task.errors.full_messages.to_sentence
			redirect_to delete_task_url(@task)
		end
	end
end

def task_params
	params.require(:task).permit(:title, :body, :expires_on, :user_id)
end