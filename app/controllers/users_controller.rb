class UsersController < ApplicationController
	before_action :set_user, only: %i[edit update destroy]
	before_action :require_user, only: [:edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Welcome to the mokoblog #{@user.username}, your account has been successfully created"
			redirect_to users_path
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "Hey #{@user.username}, your account has been successfully updated"
			redirect_to user_path(@user)
		else
			render :edit
		end
	end

	def show
		@user = User.find(params[:id])
		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		@user.destroy
		session[:user_id] = nil if @user == current_user
		flash[:notice] = "Account and all associated article deleted succefully"
		redirect_to root_path
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end

	def require_same_user
		if current_user != @user && !current_user.admin?
			flash[:alert] = "You can only edit or delete your own profile"
			redirect_to(@user)
		end
	end
end
