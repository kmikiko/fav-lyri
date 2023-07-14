class LyricsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_lyric, only: [:show, :edit, :update, :destroy]
  def index
    @q = Lyric.ransack(params[:q].try(:to_unsafe_h))
    @lyrics = @q.result.includes(:artist, :song)
  end

  def new
    @lyric = Lyric.new
    @lyric.build_song
    @lyric.build_artist
  end
  
  def create
    @lyric = Lyric.new(lyric_params)
    @lyric.user_id = current_user.id
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
    params.require(:lyric).permit(:phrase, :detail, song_attributes: [:title], artist_attributes: [:name])
  end

  def set_lyric
    @lyric = Lyric.find(params[:id])
  end
end
