require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end


ActiveRecord::Base.establish_connection(
adapter: :postgresql,
database: :restaurant
)

# create some food
[
  {
    cuisine: "Italian",
    price: 15,
    name: "Pizza",
    allergens: "wheat"
  },
  {
    cuisine: "Mexican",
    price: 12,
    name: "Fajitas",
    allergens: "dairy"
  }
].each do |food|
  Food.create( food )
end

# Create some parties
[
  {
    table_number: 1,
    guests: 3,
    paid: true
  },
  {
    table_number: 2,
    guests: 2,
    paid: true
  }
].each do |party|
  Party.create( party )
end

# Create some orders
[
  {
    food_id: 1,
    party_id: 1,
  },
  {
    food_id: 2,
    party_id: 2,
  }
].each do |order|
  Order.create( order )
end
