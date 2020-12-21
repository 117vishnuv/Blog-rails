class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    @categories = Category.all
        cate = params[:cate]
        if !cate.nil?
          @articles = Article.where(:category_id => cate )
        elsif cate=="All"
          @articles = Article.all   
        else
          @articles = Article.all
        end 
  end
end
