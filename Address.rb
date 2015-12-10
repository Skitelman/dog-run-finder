require 'net/http'
require 'open-uri'
require 'nokogiri'
require 'Geocoder'
require 'pry'
require_relative "./Import"

class Address
  attr_accessor :name, :coordinates
  def initialize(name)
    @name = name
    @coordinates = []
  end

  def get_coordinates(city = "")
    coordinates = Geocoder.coordinates(name + ", " + city)
  end

  def distance_to(other_address)
    Geocoder::Calculations.distance_between(@coordinates, other_address.coordinates)
  end
end
