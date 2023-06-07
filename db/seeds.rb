# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.create(email:'test@gmail.com', password:'secret', location:'Caracas, Venezuela', first_name:'Alejandro', last_name:'Rodriguez Hernandez')
file = File.join(__dir__, 'json/tracks.json')
hash = JSON.parse(File.open(file).read)

user.save