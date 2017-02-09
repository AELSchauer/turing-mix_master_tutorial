class SongsController < ApplicationController

  def new
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new(song_params)
    if @song.save
      redirect_to artist_path(@artist)
    else
      render :new
    end
  end

  def show
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
  end

  def edit
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
    if @song.update(song_params)
      redirect_to artist_song_path(@song)
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.find(params[:id])
    @song.destroy

    redirect_to artist_path(@artist)
  end

  private

  def song_params
    params.require(:song).permit(Song.input_fields)
  end
end