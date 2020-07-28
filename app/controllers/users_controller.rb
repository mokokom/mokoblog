class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		# username = params[:user][:username]
		# email = params[:user][:email]
		# password = params[:user][:password]
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "Welcome to the mokoblog #{@user.username}, your account has been successfully created"
			redirect_to articles_path
		else
			render :new
		end
	end

	# def index
	# 	@users = User.all
	# end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end
