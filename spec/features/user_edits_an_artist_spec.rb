require 'rails_helper'

RSpec.feature 'User edits an existing artist...' do
  let(:artist) { Artist.find_or_create_by(name: 'Bob Marlow', image_path: 'http://img.7te.org/images/570x363/bob-marley-trippy-psychedelic-art-6005906.jpg?6')}
  let(:new_artist_name) { 'Bob Marley' }
  let(:new_artist_image_path) { 'http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg?partner=allrovi.com' }

  scenario 'they see that the current page has data to update...' do
    visit artist_path(artist)

    expect(page).to have_content artist.name
    expect(page).to have_css("img[src=\"#{artist.image_path}\"]")
  end

  scenario 'they enter data to edit an existing artist...' do
    visit artist_path(artist)
    click_on 'Edit'
    fill_in 'artist_name', with: new_artist_name
    fill_in 'artist_image_path', with: new_artist_image_path
    click_on 'Submit'

    expect(page).to have_content new_artist_name
    expect(page).to have_css("img[src=\"#{new_artist_image_path}\"]")
  end

  context 'but the submitted form is invalid...' do
    scenario 'because they left "name" empty, and so they see an error message' do
      visit artist_path(artist)
      click_on 'Edit'
      fill_in "artist_name", with: ""
      click_on "Submit"

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'because they left "image_path" empty, and so they see an error message' do
      visit artist_path(artist)
      click_on 'Edit'
      fill_in "artist_image_path", with: ""
      click_on "Submit"

      expect(page).to have_content "Image path can't be blank"
    end

    scenario 'because they changed the artist name to one that already exists, and so they see an error message' do
      Artist.create(name: new_artist_name, image_path: new_artist_image_path)

      visit artist_path(artist)
      click_on 'Edit'
      fill_in "artist_name", with: new_artist_name
      click_on "Submit"

      expect(page).to have_content "Name has already been taken"
    end
  end
end