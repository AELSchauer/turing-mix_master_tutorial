def artists_hash
  {
    bob_marley: { name: 'Bob Marley', image_path: 'http://cps-static.rovicorp.com/3/JPG_400/MI0003/146/MI0003146038.jpg?partner=allrovi.com' },
    adele: { name: 'Adele', image_path: 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/Adele_2016.jpg/320px-Adele_2016.jpg' },
    imagine_dragons: { name: 'Imagine Dragons', image_path: 'https://upload.wikimedia.org/wikipedia/commons/1/11/Imagine_Dragons_2013.jpg' }
  }
end

artists_hash.values.each { |params| Artist.find_or_create_by(params) }