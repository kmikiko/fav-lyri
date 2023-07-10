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
  end

  def update
  end
  
  def show
  end

  def destroy
  end

  private

  def lyric_params
    params.require(:lyric).permit(:phrase, :detail)
  end
end
