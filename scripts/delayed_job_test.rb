ENV['RAILS_ENV'] = ARGV.first || ENV['RAILS_ENV'] || 'development'
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails'
require 'rubygems'
require 'json'

require 'httparty'


temp = HTTParty.get "https://ethgasstation.info/api/ethgasAPI.json", timeout: 10
#temp = HTTParty.get "https://ethgasstation.info/api/ethgasAPI.json"

puts temp.body

temp2 = JSON.parse(temp.body)

puts temp2["fastest"]
puts temp2["safeLow"]


WriteToFileJob.set(wait: 10.seconds).perform_later(temp.body, "ethgasAPI.txt")
WriteToFileJob.set(wait: 10.seconds).perform_later(temp2['fastest'], "ethgasAPI_fastest.txt")


puts 'end'
