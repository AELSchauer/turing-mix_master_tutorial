class SongsController < ApplicationController
  def new
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new
  end
  def create
    @artist = Artist.find(params[:artist_id])
    @song = @artist.songs.new
    if @song.save
      redirect_to artist_path(@artist)
    else
      render :new
    end
  end
  def show
    @song = Song.find(params[:id])
  end

  private

  def song_params
    params.require(:song).permit(Song.input_fields)
  end
end