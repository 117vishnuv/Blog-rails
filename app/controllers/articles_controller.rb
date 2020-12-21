class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:show]
  # http_basic_authenticate_with name: "admin", password: "11", except: [:index, :show]
  
    def new
        @article = Article.new
    end
    
    def index
        # @articles = Article.all
        @categories = Category.all
        cate = params[:cate]
        if !cate.nil?
          @articles = Article.where(:category_id => cate )
        else
          @articles = Article.all
        end 
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    def create
         @article = Article.new(article_params)
         @article.authername = current_user.username if current_user
         if @article.save
          redirect_to @article
        else
          render 'new'
        end
    end

    def edit
       @article = Article.find(params[:id])
    end 

    def update  
       @article = Article.find(params[:id])
     
      if @article.update(article_params)
         redirect_to @article
      else
        render 'edit'
      end
    end

     def destroy
       @article = Article.find(params[:id])
       @article.destroy
 
        redirect_to articles_path
     end
   
    private
    def article_params
       params.require(:article).permit(:title, :text, :authername, :category_id)
    end
end



