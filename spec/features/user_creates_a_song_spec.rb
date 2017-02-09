require 'rails_helper'

RSpec.feature 'User creates a new song...' do
  let(:artist_name) { 'Bob Marley' }
  let(:artist_image_path) { 'http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg?partner=allrovi.com' }
  let(:artist) { Artist.create(name: artist_name, image_path: artist_image_path)}
  let(:song_title) { 'No Woman No Cry' }

  scenario 'they enter data into the "New Song" form and submit' do
    visit artist_path(artist)
    click_on 'Create Song'
    fill_in 'song_title', with: song_title
    click_on 'Submit'

    expect(page).to have_content song_title
  end

  context 'but the submitted form is invalid...' do
    scenario 'because they left "title" empty, and so they see an error message' do
      visit artist_path(artist)
      click_on 'Create Song'
      click_on "Submit"

      expect(page).to have_content "Title can't be blank"
    end

    scenario 'because they entered in an song title that already exits, and so they see an error message' do
      artist.songs.create(title: song_title)

      visit artist_path(artist)
      click_on 'Create Song'
      fill_in "song_title", with: song_title
      click_on "Submit"

      expect(page).to have_content "Title has already been taken"
    end
  end
end