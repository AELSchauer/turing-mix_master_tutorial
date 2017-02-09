require 'rails_helper'

RSpec.feature 'User edits an existing song...' do
  let(:artist) { create(:artist_with_songs) }
  let(:song1) { artist.songs.first }
  let(:song2) { artist.songs.second }
  let(:song3) { artist.songs.last }
  let(:edit_song_title1) { 'I Shot the Sheriff' }
  let(:edit_song_title3) { song2.title }

  scenario 'they see that the current page has a song to update...' do
    visit artist_path(artist)

    expect(page).to have_link song1.title, href: song_path(song1)
    expect(page).to have_link song2.title, href: song_path(song2)
    expect(page).to have_link song3.title, href: song_path(song3)
  end

  scenario 'they enter data to edit an existing song...' do
    visit song_path(song1)
    click_on 'Edit'
    fill_in 'song_title', with: edit_song_title1
    click_on 'Submit'

    expect(page).to have_content edit_song_title1
  end

  context 'but the submitted form is invalid...' do
    scenario 'because they left "title" empty, and so they see an error message' do
      visit song_path(song3)

      click_on 'Edit'
      fill_in "song_title", with: ""
      click_on "Submit"

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'because they changed the song name to one that already exists, and so they see an error message' do
      visit song_path(song3)

      click_on 'Edit'
      fill_in "song_title", with: edit_song_title3
      click_on "Submit"

      binding.pry

      expect(page).to have_content "Title has already been taken"
    end
  end
end