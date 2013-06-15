#! /usr/bin/env ruby

require 'nokogiri'

=begin
doc = Nokogiri::HTML(open('lsat_vocab.html'))

regex_dict = []
tally = {}
regex_tally_dict = {}
stuff = doc.css('table tr')

stuff.each do |row|
  word = row.css('td')[0].text

  if ["de facto", "in lieu of"].include?(word)
    next
  end

  word_root = row.css('td')[1].text
  clean_word = word.split(/\s/)[0] 

  regex = ""
  if word_root.match(/^[^\w]*$/)
    regex = clean_word.downcase
  else
    regex = word_root.downcase
  end

  tally[regex] = 0
  regex_tally_dict[regex] = clean_word
  regex_dict << Regexp.new(regex)
end

tally.delete("in")
tally.delete("of")
tally["effect"] = 0
tally["affect"] = 0
tally["in lieu of"] = 0
tally["de facto"] = 0
regex_dict << /effect/
regex_dict << /affect/
regex_dict << /in lieu of/
regex_dict << /de facto/
regex_tally_dict["effect"] = "effect"
regex_tally_dict["affect"] = "affect"
regex_tally_dict["in lieu of"] = "in lieu of"
regex_tally_dict["de facto"] = "de facto"

tally["phenomenon"] = 0
regex_dict << /phenomenon/
tally["phenomena"] = 0
regex_dict << /phenomena/
tally["significant"] = 0
regex_dict << /significant/
regex_tally_dict["phenomenon"] = "phenomenon"
regex_tally_dict["phenomena"] = "phenomena"
regex_tally_dict["significant"] = "significant"

f = File.open("all.num", 'r')
lines = f.readlines
f.close

lines.each do |line|
  arr = line.split(/ /)
  word = arr[1]
  frequency = arr[0]
  regex_dict.each do |regex|
    if word.match(regex)
      tally[regex.source] += frequency.to_i
    end
  end
end

tally.each_pair do |key, val|
  puts "#{key} (was originally #{regex_tally_dict[key]}): #{val}"
end

=end
#=begin
f = File.open('frequency', 'r')
f_lines = f.readlines
f.close

# lemma => long-word, occurrence
frequency_hash = {}
f_lines.each do |line|
  arr = line.split(/\s/)
  frequency_hash[arr[0]] = [arr[1], arr[2]]
end


f = File.open('general_frequencies.txt', 'r')
f_lines = f.readlines
f.close

# lemma => longword, lsat occurrence, general occurrence 
f_lines.each do |line|
  arr = line.split(/\s/)
  if frequency_hash[arr[0]].nil?
    puts arr[0]
    next
  end
  frequency_hash[arr[0]] << arr[-1]
end

arr = frequency_hash.to_a

arr.sort! do |x, y|
  x[1][1].to_i <=> y[1][1].to_i
end

arr.each do |item|
  puts "#{item[0]} (originally #{item[1][0]}): #{item[1][1]}, #{item[1][2]}"
end
