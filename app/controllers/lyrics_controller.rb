class LyricsController < ApplicationController
  before_action :set_lyric, only: [:show, :edit, :update, :destroy]
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
    if @lyric.update(lyric_params)
      redirect_to root_path
    else
      render :edit
    end
  end
  
  def show
  end

  def destroy
    @lyric.destroy
    redirect_to root_path
  end

  private

  def lyric_params
    params.require(:lyric).permit(:phrase, :detail)
  end

  def set_lyric
    @lyric = Lyric.find(params[:id])
  end
end
