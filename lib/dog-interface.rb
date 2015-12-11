require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'Geocoder'
require 'pry'
require_relative "../lib/import"
require_relative "../lib/address"


class DogInterface




  def self.run_dogs
    addresses = Import.get_coordinates(Import.get_addresses)
    response = ""
    until response == "exit" || response == "q"
      puts "What is your address?"
      user_address = self.get_user_address
      puts "How many miles away from you should the dog run be?"
      user_max_distance = self.get_max_distance
      puts "Here are possible dog runs: "
      self.get_dog_runs(addresses, user_address, user_max_distance)
      puts "Do you want to input another address or exit?"
      response = gets.chomp
    end
  end

  private
  def self.get_user_address
    address = gets.chomp
    user_address= Address.new(address)
    user_address.get_coordinates
    user_address
  end

  def self.get_max_distance
    user_distance = gets.chomp.to_f
  end

  def self.get_dog_runs(addresses, user_address, max_distance)
    addresses.each do |address|
      distance_to_park = address.distance_to(user_address)
      if distance_to_park <= max_distance
        puts "#{address.name} is #{distance_to_park.round(2)} miles away."
      end
    end
  end
end
