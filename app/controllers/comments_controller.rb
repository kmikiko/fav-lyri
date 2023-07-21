class CommentsController < ApplicationController
  def create
    @lyric = Lyric.find(params[:lyric_id])
    @comment = @lyric.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@lyric), notice: '投稿できませんでした' }
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
