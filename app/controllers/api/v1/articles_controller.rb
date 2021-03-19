class Api::V1::ArticlesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request!

  rescue_from ActiveRecord::RecordNotFound, with: :no_article_found

  # http://localhost:3000/auth_user?email=bipinninza23@yahoo.com&password=asdfasdf to create a api bearer token
  # And then can acces API requests

  # http://localhost:3000/api/v1/articles method:get
  def index
    @articles = Article.all
    render :index, status: 200
  end

  # http://localhost:3000/api/v1/articles/5 method:get
  def show
    @article = Article.find(params[:id])
    render :show, status: 200
  end

  # http://localhost:3000/api/v1/articles/?title=heyoo&content=asdfasdf method:post
  def create
    if not_present(params[:title]) || not_present(params[:content])
      render json: 'Article was not created succesfully', status: 400 #bad request
    else
      article = user.articles.create(title: params[:title],
                                     content: params[:content])
      render json: article, status: :created #which means 201
    end
  end

  # method:patch
  # http://localhost:3000/api/v1/articles/100/?title=The hundereds&content=This is a nice show
  def update
    article = Article.find(params[:id])
    # updated_article = article.update_attributes(title:params[:title],content:params[:content],user_id:params[:user_id].to_i)
    if not_present(params[:title]) && not_present(params[:content])
      render json: 'Article was not updated successfully', status: 400
    else
      article.update_attribute(:title, params[:title])
      updated_article = article.update_attribute(:content, params[:content])
      # updated_article = article.update_attributes(:title=>params[:title],:content=>params[:content])
      render json: updated_article, status: :ok
    end
  end

  # http://localhost:3000/api/v1/articles/102/  method:delete
  def destroy
    article = Article.find(params[:id])
    if article.destroy
    render json: 'Article Delete successfully', status: :ok
    else
      render json: 'Article not deleted successfully', status: 400
    end
  end

  def no_article_found
    render json: 'Article Not found', status: 404
  end

  def not_present(val)
    val.to_s.strip.empty?
  end
end
