class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_comment, only: %i[show edit update destroy]

  before_action :authenticate_user!, except: %i[index show]

  # GET /comments or /comments.json
  def index
    # @comments = Comment.all
  end

  # GET /comments/1 or /comments/1.json
  def show; end

  # GET /comments/new
  def new
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new
  end

  # GET /comments/1/edit
  def edit; end

  # POST /comments or /comments.json
  def create
    # binding.pry
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params.merge(user_id: current_user.id))
    # binding.pry

    respond_to do |format|
      if @comment.save
        # Uncomment to send mail on comment addition
        # WelcomeMailer.custom_mail(@article.user, 'A new Comment has been added',@comment).deliver

        #Send a mail through csv mailer service object
        CsvMailer.new(@article,@comment).delay.call

        com = ApplicationController.render(
          partial: 'comments/comment',
          locals: { comment: @comment, current_user: current_user }
        )
        ActionCable.server.broadcast 'comment_channel', comment: @comment, html: com, type: 'add'

        format.html { redirect_to article_path(@article), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        com = ApplicationController.render(
          partial: 'comments/comment',
          locals: { comment: @comment, current_user: current_user }
        )
        ActionCable.server.broadcast 'comment_channel', comment: @comment, html: com, type: 'add'
        format.html { redirect_to @article, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    ActionCable.server.broadcast 'comment_channel', comment: @comment, type: 'delete'
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_path(@article), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:name, :body, :article_id)
  end
end
