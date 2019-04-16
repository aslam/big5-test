#!/usr/bin/ruby

require 'bundler/inline'

gemfile do
    source 'https://rubygems.org'
    gem 'httparty'
end

puts "The HTTParty gem is at version #{HTTParty::VERSION}"

require_relative 'big_five_results_text_serializer'
require_relative 'big_five_results_poster'

serializer = BigFiveResultsTextSerializer.new "facets.txt"
results = serializer.to_h

puts "Results: #{results.inspect}"

email = ARGV[0]

if !email
    puts
    puts "Please enter email: "
    email = gets.chomp
end

poster = BigFiveResultsPoster.new(results, email)
response = poster.post

p "Poster response: #{response}"
