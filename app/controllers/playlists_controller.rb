class PlaylistsController < ApplicationController
  def index
    @playlists = Playlist.all
  end

  def new
    @playlist = Playlist.new
    @songs    = Song.all.order(:title)
    @song_ids = []
  end

  def create
    @playlist = Playlist.new(playlist_params)
    @songs    = Song.where({ id: params[:playlist][:song_ids] })

    if @playlist.save
      @playlist.songs << @songs
      redirect_to playlist_path(@playlist)
    else
      render :new
    end
  end

  def show
    @playlist = Playlist.find(params[:id])
  end

  def edit
    @playlist = Playlist.find(params[:id])
    @songs    = Song.all.order(:title)
    @song_ids = @playlist.songs.pluck(:id)
  end

  def update
    @playlist = Playlist.find(params[:id])
    @songs = Song.where({ id: params[:playlist][:song_ids] }) || @playlist.songs

    if @playlist.update(playlist_params)
      if @songs != @playlist.songs
        @playlist.playlist_songs.destroy_all
        @playlist.songs << @songs
      end
      redirect_to playlist_path(@playlist)
    else
      render :edit
    end
  end

  private

  def playlist_params
    params.require(:playlist).permit(Playlist.input_fields)
  end
end
