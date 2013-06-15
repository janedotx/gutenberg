#! /usr/bin/env ruby

require 'nokogiri'

#=begin
f = File.open('frequency', 'r')
f_lines = f.readlines
f.close

frequency_hash = {}
f_lines.each do |line|
  arr = line.split(/\s/)
  frequency_hash[arr[0]] = [arr[1], arr[2]]
end


f = File.open('general_frequencies.txt', 'r')
f_lines = f.readlines
f.close

all_hash = {}
f_lines.each do |line|
  arr = line.split(/\s/)
  all_hash[arr[0]] = arr[-1]
end

frequency_hash.each_pair do |key, val|
  puts "#{key}, was originally #{val[0]}, found #{val[1]} times in LSATs, #{all_hash[key]} times in general English"
end
#=end
