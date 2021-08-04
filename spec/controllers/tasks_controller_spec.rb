require 'rails_helper'

RSpec.describe TasksController do
	describe 'POST #create' do
		let(:create_valid_task) do
			create(:user, firstname:"Devashish" , lastname:"Taneja") do |user|
				post :create, params: { task: attributes_for(:task, user_id: user.id)}
			end
		end

		let(:create_invalid_task) do
			create(:user, firstname:"Devashish" , lastname:"Taneja") do |user|
				post :create, params: { task: attributes_for(:task, title:'', user_id: user.id)}
			end
		end

		context 'with valid attributes' do
			it 'should increase the post count by 1' do
				expect{create_valid_task}.to change(Task,:count).by(1)
			end
		end

		context 'with invalid attributes' do
			it 'should not add to task' do
				expect{create_invalid_task}.not_to change(Task, :count)
			end
		end
	end

	describe 'PATCH #update' do
		before :example do
			@task = create :task
		end

		it 'should be able to reassign task' do
			expect(@task.user.name).to eq('John Doe')
			new_user = create(:user, firstname: 'New', lastname: 'User')
			post :update, params: { id: @task.id, task: attributes_for(:task, user_id: new_user.id) }
			@task.reload
			expect(@task.user.name).to eq('New User')
		end

		it 'should be able to rename task title' do
			expect(@task.title).to eq('Task Title')
			post :update, params: { id: @task.id, task: attributes_for(:task, title: 'New Task Title') }
			@task.reload
			expect(@task.title).to eq('New Task Title')
		end

		it 'should be able to update task body' do
			expect(@task.body).to eq('Task Content')
			post :update, params: { id: @task.id, task: attributes_for(:task, body: 'New Task Content') }
			@task.reload
			expect(@task.body).to eq('New Task Content')
		end

		it 'should be able to update the expiry date' do
			new_time = Time.now+10000
			post :update, params: { id: @task.id, task: attributes_for(:task, expires_on: new_time) }
			@task.reload
			expect(@task.expires_on.to_i).to eq(new_time.to_i)
		end

	end

end