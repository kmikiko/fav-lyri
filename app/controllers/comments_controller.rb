class CommentsController < ApplicationController
  before_action :set_lyric, only: [:create, :edit, :update]
  def create
    @comment = @lyric.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@lyric), notice: '投稿できませんでした' }
      end
    end
  end

  def edit
    @comment = @lyric.comments.find(params[:id])
    respond_to do |format|
      flash.now[:notice] = 'コメントの編集中'
      format.js { render :edit }
    end
  end

  def update
    @comment = @lyric.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          flash.now[:notice] = 'コメントが編集されました'
          format.js { render :index}
        else
          flash.now[:notice] = 'コメントの編集に失敗しました'
          format.js { render :edit }
        end
      end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_lyric
    @lyric = Lyric.find(params[:lyric_id])
  end
end
