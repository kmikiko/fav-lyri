class LyricsController < ApplicationController
  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  before_action :authenticate_user!, only: %i[new create]
  before_action :set_lyric, only: %i[show edit update destroy]
  
  def index
    @q = Lyric.ransack(params[:q].try(:to_unsafe_h))
    @feelings = Feeling.all
    @lyrics = @q.result.includes(:artist, :song, :feelings, :lyrics_feelings).order(created_at: :desc)
    @favorite_count = Favorite.where(lyric_id: @lyrics.map(&:id)).group(:lyric_id).count
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
      redirect_to lyrics_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lyric.update(lyric_params)
      redirect_to lyrics_path
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
    @favorite_count = Favorite.where(lyric_id: @lyric.id).group(:lyric_id).count
  end

  def destroy
    @lyric.destroy
    redirect_to lyrics_path
  end

  def ranking
    @rank_lyrics = Lyric.recently_created.ranked.with_associations.limit(5)
    @lyric_comments_count = Comment.where(lyric_id: @rank_lyrics.map(&:id)).group(:lyric_id).count
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

  # require "openai"

  # def explain
  #   @phrase = @lyric.phrase
  #   @song = @lyric.song.title
  #   @artist = @lyric.artist.name

  #   client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  #   response = client.chat(
  #       parameters: {
  #         model: "gpt-3.5-turbo-0613",
  #         messages: [
  #           { role: "system", content: "曲名と歌手名とその曲に含まれる歌詞を伝えるので、その歌詞に込められた意図を推察して教えてください。" },
  #           { role: "system", content: "100字以内で回答してください。"},
  #           { role: "system", content: "回答には、「他に何か別の質問やトピックについてお知りになりたいことがあれば、どうぞお知らせください。」のような、次の質問を促すような文言は含めないでください。" },
  #           { role: "system", content: "「データベースには含まれておりません」という回答は不要です。" },
  #           { role: "system", content: "「この歌詞の解釈は、個人によって異なるかもしれません」という回答は不要です。" },
  #           { role: "system", content: "「ただし、これは一つの解釈であり、個人によって解釈が異なる可能性もあります」という回答は不要です。" },
  #           { role: "system", content: "「具体的な解釈は聴く人によって異なる可能性があるので、個々の解釈は多様であることに留意してください」という回答は不要です。"},
  #           { role: "system", content: "「具体的な意図は個人の解釈によって異なるかもしれません」という旨の回答は不要です。"},
  #           { role: "user", content: "#{@artist}の#{@song}という曲について、#{@phrase}という歌詞があります。その歌詞に込められた意図を推察して教えてください。" },
  #           { role: "user", content: "もし、「#{@artist}」の「#{@song}」や「#{@phrase}」といった楽曲や歌詞についての情報があなたのデータベースには含まれていない場合は、『歌詞についての説明が作成できませんでした』とだけ答え、その他に余計な文章を答えないでください。" },
  #           { role: "user", content: "回答は、「この歌詞は」で始めてください。" },
  #         ],
  #       },
  #     )

  #   @explain = response.dig("choices", 0, "message", "content")
  # end

  private

  def lyric_params
    params.require(:lyric).permit(:phrase, :detail, song_attributes: [:title], artist_attributes: [:name], feeling_ids: [] )
  end

  def set_lyric
    @lyric = Lyric.includes(:favorites, :comments, :song, :artist).find(params[:id])
  end
end
