class UsersController < ApplicationController
<<<<<<< HEAD
	before_action :signed_in_user, only: [:edit, :update]
	before_action :correct_user, only: [:edit, :update]
=======
	before_filter :signed_in_user, only: [:show]
	# before_filter :correct_user, only: [:edit, :update]
>>>>>>> 24268e3c78fdcffd2bf081ea7c7c087e5a2b9c37
	def new
		@user = User.new
	end

	def index
		@users = User.all
	end
	
	def show
    	@user = User.find(params[:id])
    	@events = @user.events.paginate(page: params[:page])
  	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to UCLAevents!"
			redirect_to @user
		else 
			render 'new'
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = "Profile change successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def signed_in_user
		unless signed_in?
			store_location
			flash[:danger] = "Please sign in first!"
			redirect_to signin_url
		end
	end	

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_url) unless @user == current_user
	end

	private
	  	def user_params
	    	params.require(:user).permit(:name, :email, :password,
	                                   :password_confirmation)
	  	end

	  	# Confirms the correct user.
	    def correct_user
	      @user = User.find(params[:id])
	      redirect_to root_url unless current_user?(@user)
	    end
end
