class CategoriesController < ApplicationController
	def index
		
	end

	def show
		
	end

	def edit
		
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "Category successfully created"
			redirect_to category_path(@category)
		else
			render :new
		end
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end
end