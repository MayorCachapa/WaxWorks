require 'httparty'

puts 'Seeding...'
user = User.create(email:'test@gmail.com', password:'secret', location:'Caracas, Venezuela', first_name:'Alejandro', last_name:'Rodriguez Hernandez')
# file = File.join(__dir__, 'json/tracks.json')
# hash = JSON.parse(File.open(file).read)
# user.save

albums = ['And Justice for All', 'Nevermind', 'Peace Sells', 'Crack the Skye', 'New Levels New Devils']
albums.each do |album|
  response = HTTParty.get("https://api.discogs.com/database/search?q=#{album}&token=AEgKooIfiZVMfmmICvVLurkTqfBVZtDyUtRcjTYE")
  data = JSON.parse(response.body)
  if data['results'].any?
    result = data['results'].first['title'].split('-')
    artist = result[0].strip
    release = result[1].strip
    Release.create(artist: artist, title: release)
  end
end

releases = Release.all
for release in releases
  listing = Listing.create(user_id: user.id, condition: "Excelent", sleeve_condition: "Excelent", price: 15.99, shipping_fee: 3.50, comments:'Classic', location: user.location, release: release)
end

puts 'Finished successfully'

# Validations for later
    # if results.any?
    #     artist_name = results.first['title']
    # else
    #     puts 'Error'
    # end

    # puts artist_name
    
# Validations for later
    # if results.any?
    #     artist_album = results.first['title']
    # else
    #     puts 'Error'
    # end

    # puts artist_album