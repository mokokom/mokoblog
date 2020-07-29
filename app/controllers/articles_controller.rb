class ArticlesController < ApplicationController
	before_action :set_article, only: [:show, :edit, :update, :destroy]
	
	def index
		# @articles = Article.all
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def show
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		# hard code waiting for authentification
		@article.user = User.first
		if @article.save
			flash[:notice] = "Article has been created successfully"
			redirect_to @article
		else
			render :new
		end
	end

	def edit
	end

	def update	
			if @article.update(article_params)
				flash[:notice] = "Article has been updated successfully"
				redirect_to @article
			else
				render :edit
			end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end

	private

	def article_params
		params.require(:article).permit(:title, :description)
	end

	def set_article
		@article = Article.find(params[:id])
	end
end
