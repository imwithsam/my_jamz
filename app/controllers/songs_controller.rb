class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]

  def index
    @songs = Song.all
  end

  def show
  end

  def new
    @song = Song.new
  end

  def create
    # Using the form_for method you will grab params[:song]
    # Song.create(params[:song])
    # This way is the secure way to do it in Rails 4
    song = Song.new(song_params)

    if song.save
      session[:most_recent_song_title] = song_params[:title]
      flash[:notice] = "#{song_params[:title]} added!"
    else
      flash[:error] = "Song could not be added."
    end

    redirect_to songs_path
  end

  # This is required in Rails 4 as a security measure
  #   to limit what form fields can be created/updated
  def edit
  end

  def update
    @song.update(song_params)
    redirect_to @song
  end

  def destroy
    @song.delete
    redirect_to songs_path
  end

  private

  def set_song
    @song = Song.find(params[:id])
  end
  
  def song_params
    params.require(:song).permit(:title, :artist)
  end
end
