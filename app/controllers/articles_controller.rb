class ArticlesController < ApplicationController
  load_and_authorize_resource except: %i[like dislike import all export generate]

  before_action :set_article, only: %i[show edit update destroy like dislike export_article]
  before_action :authenticate_user!, except: %i[index show]
  skip_before_action :verify_authenticity_token


  # GET /articles or /articles.json
  def index
    @articles = Article.includes(:comments, :user, :image).recent.page params[:page] # Using eager loading
    # @articles = Article.joins(:user).select('articles.*,users.username as user_name')
    # @articles = Article.all
  end

  def all
    @articles = Article.all.includes(:user)
  end

  def export
    @ids = []
    @selected = []
    params.each { |k, v| @ids << k if v == '1' }
    @selected = Article.all.select { |article| @selected << article if @ids.include?(article.id.to_s) }

    ArticlesExporter.new(current_user, params[:export_all] == '0' ? @selected : Article.all).delay.call

    # csv_string = ArticlesExporter.new(@selected).call
    # send_data csv_string,
    #           type: 'text/csv',
    #           filename: "#{Time.now.getutc}_articles.csv",
    #           disposition: 'attachment',
    #           notice: 'Articles were exported sucessfully'
    redirect_to all_path, notice: 'Articles will be mailed to you shortly'
  end

  # def download
  # ExportCsv.new(@search.to_a.map(&:id), current_user.id).delay.perform
  # end

  def import; end

  def generate
    if params[:data]
      @file = CsvFile.new(data: params[:data].read, name: params[:data].original_filename,
                          mime_type: params[:data].content_type)
      if @file.save
        ArticlesImporter.new(@file.id, current_user.id).delay.call
        redirect_to articles_url, notice: 'Articles have been added to import queue.'
      end
    else
      redirect_to articles_url, notice: 'File not saved'
    end
  end

  # GET /articles/1 or /articles/1.json
  def show
    @count_of_users_comment = @article.comments.distinct.pluck(:user_id).count # select unique ids from comments and count
    @user_comment_count = @article.comments.where(user_id: current_user.id).count if user_signed_in?

    # @user_comment_count = @article.comments.count
    @article_comments = @article.comments.order('comments.updated_at DESC').includes(:user).page params[:page]
  end

  # GET /articles/new
  def new
    @article = current_user.articles.build
  end

  # GET /articles/1/edit
  def edit; end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.build(article_params)

    #  binding.pry
    respond_to do |format|
      if @article.save
        @article.create_image(params.require(:article).permit(:picture))
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        @article.create_image(params.require(:article).permit(:picture))
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def like
    @article.liked_by current_user
    SendLikeJob.perform_later(@article)
  end

  def dislike
    @article.disliked_by current_user
    SendLikeJob.perform_later(@article)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :content, :user_id)
  end
end
