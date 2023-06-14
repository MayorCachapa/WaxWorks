require 'httparty'
# require 'dotenv/load'

Order.destroy_all
Ownership.destroy_all
Favorite.destroy_all
Listing.destroy_all
User.destroy_all

Release.destroy_all
Product.destroy_all

puts 'Seeding...'
user = User.create(
  email:'test@gmail.com',
  password:'secret',
  location:'Caracas, Venezuela',
  full_name:'Alejandro Rodriguez Hernandez',
  uid: '',
  avatar_url: '',
  provider: ''
)
# file = File.join(__dir__, 'json/tracks.json')
# hash = JSON.parse(File.open(file).read)
# user.save

albums = ['And Justice for All', 'Nevermind', 'Peace Sells', 'Crack the Skye', 'New Levels New Devils', 'Five Easy Hot Dogs', 'Bossanova', 'Hammer of witches']

albums.each do |album|
  response = HTTParty.get("https://api.discogs.com/database/search?q=#{album}&token=#{ENV['DISCOG_TOKEN']}")

  data = JSON.parse(response.body)
  results = data['results']

  if results.any?
    result = results.first['title'].split(' - ')
    format = results.first['format']

    master_id = results.first['master_id']

    response_masters = HTTParty.get("https://api.discogs.com/masters/#{master_id}")
    data_masters = JSON.parse(response_masters.body)

    release_id = data_masters['main_release']

    response_release = HTTParty.get("https://api.discogs.com/releases/#{release_id}")
    data_release = JSON.parse(response_release.body)

    description = data_release['notes']
    date = data_release['released_formatted']

    if description.nil?
      description = "https://www.discogs.com/master/#{master_id}"
    end

    if data_masters['tracklist']
      tracklist = data_masters['tracklist']
      track_titles = tracklist.map {|track| track['title']}
      # puts track_titles
    end

    format = format.nil? ? 'Unknown' : format.join(', ')

    url = results.first['cover_image']
    artist = result[0].strip
    release_record = result[1].strip

    release = Release.create(
      artist: artist,
      title: release_record,
      url: url,
      format: format,
      tracklist: track_titles,
      description: description,
      date: date
    )

    if release.nil?
      puts "Error with Release"
    end

    if release.persisted?
      listing = Listing.create(
        user_id: user.id,
        condition: 'Excellent',
        sleeve_condition: 'Excellent',
        price_cents: 15.99,
        shipping_fee: 3.50,
        comments: 'Classic',
        location: user.location,
        release: release
      )
      if listing.nil?
        puts "Error with Listing"
      end
    end
  end
end

releases = Release.all
for release in releases

  listing = Listing.create(user_id: user.id, condition: "Excelent", sleeve_condition: "Excelent", price_cents: 1599, shipping_fee: 3.50, comments:'Classic', location: user.location, release: release)

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
