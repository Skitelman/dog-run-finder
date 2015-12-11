require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'Geocoder'
require 'pry'
require_relative "../lib/address"

class Import

  IMPORT_URL = "http://www.nycgovparks.org/bigapps/DPR_DogRuns_001.xml"

  def self.get_addresses
    addresses = Nokogiri::XML(open(IMPORT_URL))
    address_array = addresses.search("Address").collect do |address|
      address_text = address.children.text
      if address_text == "" || address_text.include?("Except")
      else
        Address.new(address_text)
      end
    end
    address_array.compact
  end

  def self.get_coordinates(addresses)
    addresses.collect do |address|
      sleep(0.2)
      address.get_coordinates("New York, NY")
    end
  end

end
