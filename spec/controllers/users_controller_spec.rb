require 'rails_helper'

RSpec.describe UsersController do
	describe 'Get #index' do
		before(:example) { get :index }

		it 'should return status ok' do
			expect(response).to have_http_status(:ok)
		end

		it "should render 'index' Template" do
			expect(response).to render_template('index')
		end
	end

	describe "GET #new" do
		before(:example) { get :new }

		it 'should return status ok' do
			expect(response).to have_http_status(:ok)
		end

		it "should render 'new' Template" do
			expect(response).to render_template('new')
		end
	end

	describe "POST #create" do
		let(:create_valid_user){ post :create, params: { user: attributes_for(:user) } }
		let(:create_invalid_user){ post :create, params: { user: attributes_for(:user, email: nil) } }

		context 'with valid attributes' do
			it 'should increase the User count by 1' do
				expect{create_valid_user}.to change(User, :count).by(1)
			end

			it 'should redirect to home page' do
				expect(create_valid_user).to redirect_to(root_url)
			end
		end

		context 'with invalid attributes' do
			it 'should not be added to database' do
				expect{create_invalid_user}.not_to change(User, :count)
			end

			it 'should redirect to signup page' do
				expect(create_invalid_user).to render_template('new')
			end

			# it 'should set flash alert' do
			# 	expect(flash[:error]).to be_present
			# end
		end
	end

end