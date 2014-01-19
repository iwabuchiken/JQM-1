# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

names       = ["aaa", "bbb", "ccc", "ddd"]
stores      = [2,1,2,1]
mobile_ids  = [10, 11, 12, 13]

names.size.times do |i|
    
    Item.create(
            name:       names[i],
            store_id:   stores[i],
            mobile_id:  mobile_ids[i])
    
end
