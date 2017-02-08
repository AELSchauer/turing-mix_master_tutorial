require 'rails_helper'

RSpec.feature 'User creates a new artist...' do
  let(:artist_name) { 'Bob Marley' }
  let(:artist_image_path) { 'http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg?partner=allrovi.com' }

  scenario 'they enter data into the "Create Artist" form and submit' do
    visit '/artists'
    click_on 'Create Artist'
    fill_in 'artist_name', with: artist_name
    fill_in 'artist_image_path', with: artist_image_path
    click_on 'Submit'

    expect(page).to have_content artist_name
    expect(page).to have_css("img[src=\"#{artist_image_path}\"]")
  end

  context 'but the submitted form is invalid...' do
    scenario 'because they left "name" empty, and so they see an error message' do
      visit artists_path
      click_on 'Create Artist'
      fill_in "artist_image_path", with: artist_image_path
      click_on "Submit"

      expect(page).to have_content "Name can't be blank"
    end

    scenario 'because they left "image_path" empty, and so they see an error message' do
      visit artists_path
      click_on 'Create Artist'
      fill_in "artist_name", with: artist_name
      click_on "Submit"

      expect(page).to have_content "Image path can't be blank"
    end

    scenario 'because they entered in an artist name that already exits, and so they see an error message' do
      Artist.create(name: artist_name, image_path: artist_image_path)

      visit artists_path
      click_on 'Create Artist'
      fill_in "artist_name", with: artist_name
      click_on "Submit"

      expect(page).to have_content "Name has already been taken"
    end
  end
end