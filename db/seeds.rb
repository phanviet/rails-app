# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

['iPhone 4', 'iPhone 4s', 'iPhone 5', 'iPhone 5s', 'iPhone retina',
 'Galayxy s6', 'Oppo N1', 'Xperia Z3'].each do |name|
  Product.find_or_create_by(name: name)
end
