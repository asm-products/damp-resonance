# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
    Category.create([{ name: 'Antiques' }, 
                      { name: 'Baby Clothes' },
                      { name: 'Baby Toys' },
                      { name: 'Bikes' },
                      { name: 'Boats' },
                      { name: 'Books' },
                      { name: 'Campers' },
                      { name: 'Womens Clothes' }, 
                      { name: 'Mens Clothes' },
                      { name: 'Computer' },
                      { name: 'Electronics' },
                      { name: 'Cars' },
                      { name: 'Trucks' },
                      { name: 'ATVs' },
                      { name: 'Tools' },
                      { name: 'Motorcycles' },
                      { name: 'Appliances' }, 
                      { name: 'Video Games' },
                      { name: 'Toys' },                
                      { name: 'Furniture' },
                      { name: 'Household' },
                      { name: 'Jobs' }, 
                      { name: 'Collectibles' },
                      { name: 'Property For Sale' }, 
                      { name: 'Property For Rent',
                      { name: 'Yard Sales' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#user = CreateAdminService.new.call
#puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.
