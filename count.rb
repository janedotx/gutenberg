#! /usr/bin/env ruby

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

# let's remember to always export to .csv files from now on, honey
require 'nokogiri'

# the following block merely exists as an example of how to use nokogiri 
# for your edification
# don't actually uncomment it
=begin

doc = Nokogiri::HTML(open('lsat_vocab.html'))
stuff = doc.css('table tr')
  word = row.css('td')[0].text
=end

regex_dict = []
tally = {}
regex_tally_dict = {}

lines = File.open("lemmatized.csv", 'r').readlines

lines.each do |line|
  next if line == ";;\n"
  
  arr = line.split(/;/)
  word = arr[0]
  regex = arr[1]
  manual = arr[2]

  if manual == "\"manual\"\n"
    next
  end

  if regex == ""
    regex = word
  end

  regex = Regexp.new(regex.gsub(/\"/, ''), Regexp::IGNORECASE)

  tally[regex] = 0
  regex_tally_dict[regex] = word
  regex_dict << regex
end
#raise 'hell'

prep_tests = `ls lsat_preptests`.split("\n")
=begin
prep_tests = ["LSAT-December-2012.txt"]

str = "passage passages passages."

str.split(/\s/).each do |word|
      regex_dict.each do |entry|
        if word.match(entry)
        
          tally[entry] += 1
        end
      end
end
=end

#=begin
prep_tests.each do |test|
#  puts "test: #{test}"
  if test =~ /txt/
    f = File.open("lsat_preptests/#{test}")
    test_text = f.read
    f.close
    test_text.split(/\s/).each do |word|
      word.downcase!

      regex_dict.each do |entry|
        if word.match(entry)
          tally[entry] += 1
        end
      end
    end
  end
end
#=end

tally = tally.to_a.sort { |x, y| x[1] <=> y[1] }
#=begin
tally.each do |item|
  puts "#{item[0].source},(#{regex_tally_dict[item[0]]}),#{item[1]}"
end
#=end

=begin
tally.each_pair do |key, val|
  puts "#{key}: #{val}"
end
=end
