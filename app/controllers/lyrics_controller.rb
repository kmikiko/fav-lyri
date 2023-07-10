class LyricsController < ApplicationController
  def index
    @lyrics = Lyric.all
  end

  def new
    @lyric = Lyric.new
  end

  def create
    @lyric = Lyric.new(lyric_params)
    if @lyric.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @lyric = Lyric.find(params[:id])
  end

  def update
    @lyric = Lyric.find(params[:id])
    if @lyric.update(lyric_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def show
    @lyric = Lyric.find(params[:id])
  end

  def destroy
  end

  private

  def lyric_params
    params.require(:lyric).permit(:phrase, :detail)
  end
end
