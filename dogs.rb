require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'Geocoder'
require 'pry'
require_relative "Import"
require_relative "Address"

# class Import
#
#   URL = "http://www.nycgovparks.org/bigapps/DPR_DogRuns_001.xml"
#
#   def self.get_addresses
#     addresses = Nokogiri::XML(open(URL))
#     address_array = addresses.search("Address").collect do |address|
#       address_text = address.children.text
#       if address_text == "" || address_text.include?("Except")
#       else
#         Address.new(address_text)
#       end
#     end
#     address_array.compact
#   end
#
#   def self.get_coordinates(addresses)
#     addresses.collect do |address|
#         sleep(0.2)
#       address.get_coordinates("New York, NY")
#     end
#   end
#
# end
#
# class Address
#   attr_accessor :name, :coordinates
#   def initialize(name)
#     @name = name
#     @coordinates = []
#   end
#
#   def get_coordinates(city = "")
#     coordinates = Geocoder.coordinates(name + ", " + city)
#   end
#
#   def distance_to(other_address)
#     Geocoder::Calculations.distance_between(@coordinates, other_address.coordinates)
#   end
# end

addresses = Import.get_coordinates(Import.get_addresses)
response = ""
until response == "exit" || response == "q"
  puts "What is your address?"
  # user_address_name = gets.chomp
  # user_address = Address.new(user_address_name)
  # user_address.get_coordinates
  user_address = get_user_address
  puts "How far will you go to a dog run?"
  # user_distance = gets.chomp.to_i
  user_max_distance = get_max_distance
  puts "Here are possible dog runs: "
  # addresses.each do |address|
  #   distance_to_park = address.distance(user_address)
  #   if distance_to_park <= user_max_distance
  #     puts "#{address.name} is #{distance_to_park} miles away."
  #   end
  # end

  puts "Do you want to input another address or exit?"
  response = gets.chomp

end

def get_user_address
  user_address= Address.new(gets.chomp)
  user_address.get_coordinates
end

def get_max_distance
  user_distance = gets.chomp.to_i
end

def get_dog_runs(addresses, user_address, max_distance)
  addresses.each do |address|
    distance_to_park = address.distance(user_address)
    if distance_to_park <= user_max_distance
      puts "#{address.name} is #{distance_to_park} miles away."
    end
  end
end
