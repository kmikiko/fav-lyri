class LyricsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_lyric, only: [:show, :edit, :update, :destroy]
  
  def index
    @q = Lyric.ransack(params[:q].try(:to_unsafe_h))
    @feelings = Feeling.all
    @lyrics = @q.result.includes(:artist, :song, :feelings, :lyrics_feelings).order(created_at: :desc)
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
    if user_signed_in?
      @favorite = current_user.favorites.find_by(lyric_id: @lyric.id)
    end
    impressionist(@lyric, nil, unique: [:ip_address]) 
    @comments = @lyric.comments
    @comment = @lyric.comments.build
    @tracks = []
    song = @lyric.song.title
    artist = @lyric.artist.name
    tracks = RSpotify::Track.search("#{song} #{artist}")
    tracks.each do |track|
      url = track.preview_url
      @tracks << { lyric: @lyric, url: url, track: track }
    end
  end

  def destroy
    @lyric.destroy
    redirect_to root_path
  end

  def ranking
    @rank_lyrics = Lyric.recently_created.ranked.includes(:song, :artist, user: :user_profile).limit(5)
    @tracks = []
    @rank_lyrics.each do |rank_lyric|
      song = rank_lyric.song.title
      artist = rank_lyric.artist.name
      tracks = RSpotify::Track.search("#{song} #{artist}")
      tracks.each do |track|
        url = track.preview_url
        @tracks << { lyric: rank_lyric, url: url, track: track }
      end
    end
  end

  private

  def lyric_params
    params.require(:lyric).permit(:phrase, :detail, song_attributes: [:title], artist_attributes: [:name], feeling_ids: [] )
  end

  def set_lyric
    @lyric = Lyric.find(params[:id])
  end
end
