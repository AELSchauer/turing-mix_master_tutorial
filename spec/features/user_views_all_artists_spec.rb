require 'rails_helper'

RSpec.feature 'User visits a the artists index page...' do
  def artists_hash
    {
      bob_marley: { name: 'Bob Marley', image_path: 'http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg?partner=allrovi.com' },
      adele: { name: 'Adele', image_path: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Adele_2016.jpg/320px-Adele_2016.jpg' },
      imagine_dragons: { name: 'Imagine Dragons', image_path: 'https://upload.wikimedia.org/wikipedia/commons/1/11/Imagine_Dragons_2013.jpg' }
    }
  end

  let!(:artists) { artists_hash.values.map { |params| Artist.find_or_create_by(params) } }

  scenario "they see the name of each artist with a link to their details page" do
    visit artists_path

    artists.each do |artist|
      expect(page).to have_link artist.name, href: artist_path(artist)
    end
  end
end