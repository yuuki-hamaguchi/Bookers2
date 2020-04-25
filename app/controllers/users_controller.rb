class UsersController < ApplicationController
	before_action :authenticate_user!
	def show
		@book = Book.new
		@user = User.find(params[:id])
		@books = @user.books
	end

	def index
		@users = User.all
		@books = Book.all
		@book = Book.new
		@user = current_user
	end

	def edit
		@user = User.find(params[:id])
		unless current_user.id == @user.id
			redirect_to user_path(current_user)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
		   flash[:notice] = "You have updated user successfully"
		   redirect_to user_path(@user.id)
		else
			render "edit"
		end
	end

	def new
		@user = User.new
	end

	private

	def user_params
	params.require(:user).permit(:profile_image,:introduction,:name)
	end
end
