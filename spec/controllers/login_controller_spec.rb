require 'rails_helper'

RSpec.describe LoginController do
	describe 'Get #index' do
		before(:example) { get :index }

		it 'should return status ok' do
			expect(response).to have_http_status(:ok)
		end

		it "should render 'index' Template" do
			expect(response).to render_template('index')
		end
	end

	describe '#login' do
		let :valid_login do
			user = create(:user)
			post :login, params: { user: { email: user.email, password: "foobar" }}
			user
		end

		let :invalid_login do
			user = create(:user)
			post :login, params: { user: { email: user.email, password: "wrong password" }}
		end

		let :inexistent_user do
			user = create(:user)
			post :login, params: { user: { email: "nonexistent@gmail.com", password: "wrong password" }}
		end

		context 'with correct credentials' do
			it 'should add user to session' do
				user = valid_login
				expect(session[:user_id]).to eq(user.id)
			end

			it 'should redirect to home' do
				expect(valid_login).to redirect_to root_path
			end

			it 'should set flash info' do
				valid_login
				expect(flash[:info]).to be_present
			end
		end

		context 'with incorrect credentials' do
			it 'should redirect to login' do
				expect(invalid_login).to render_template('index')
			end

			it 'should set flash alert' do
				invalid_login
				expect(flash[:alert]).to be_present
			end
		end

		context 'with inexistent user' do
			it 'should redirect to login' do
				expect(inexistent_user).to render_template('index')
			end

			it 'should set flash alert' do
				inexistent_user
				expect(flash[:alert]).to be_present
			end
		end
	end

	describe '#logout' do
		let :valid_login do
			user = create(:user)
			post :login, params: { user: { email: user.email, password: "foobar" }}
			user
		end

		let(:logout) { delete :logout }

		it 'should delete the session' do
			user = valid_login
			expect(session[:user_id]).to eq(user.id)
			logout
			expect(session[:user_id]).to be_nil
		end

		it 'should redirect to home' do
			user = valid_login
			expect(logout).to redirect_to(root_path)
		end

		it 'should set current user' do
			user = valid_login
			logout
			expect(@current_user).to be_nil
		end

		it 'should expect success info' do
			user = valid_login
			logout
			expect(flash[:info]).to be_present
		end
	end
end