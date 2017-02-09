require 'rails_helper'

RSpec.feature 'User visits the playlists index page...' do
  let(:songs) { create_list(:song, 12) }
  let(:playlists) { create_list(:playlist, 3) }

  scenario "they see the name of each playlist with a link to their details page" do
    playlists.each { |playlist| playlist.songs << Song.all.sample(3) }

    visit playlists_path

    playlists.each do |playlist|
      expect(page).to have_link playlist.name, href: playlist_path(playlist)
    end
  end
end