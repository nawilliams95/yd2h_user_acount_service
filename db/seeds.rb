# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([ 
    {username: 'cutiewho', password: 'Christmas', first_name: 'CindyLu', last_name: 'Who', email: 'grinchlover@fake.com', avatar_img: 'https://i.ibb.co/VJ8wxMW/avatar-1577909-1280.webp'},
    {username: 'peepingTom', password: 'Thomas', first_name: 'Thomas', last_name: 'Peeper', email: 'tommyboy@fake.com', avatar_img: 'https://i.ibb.co/VJ8wxMW/avatar-1577909-1280.webp'},
    {username: 'greenmachine', password: 'IhateChristmas', first_name: 'The Grinch', last_name: 'Who stole Christmas', email: 'themeanone@fake.com', avatar_img: 'https://i.ibb.co/VJ8wxMW/avatar-1577909-1280.webp'}
])

puts "seeded database!!"