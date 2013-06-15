#! /usr/bin/env ruby

=begin
f = File.open("lsat_vocab_latest_from_ellen.csv", 'r')
g = File.open("lsat_vocab_short.csv", 'r')

f_lines = f.readlines
g_lines = g.readlines

f.close
g.close

lemma_hash = {}

g_lines.each do |line|
  arr = line.split(",")
  lemma_hash[arr[0]] = arr[1]
end

f_lines.each do |line|
  arr = line.split(",")
  word = arr[0]
  if lemma_hash[word]
    next
  else
    lemma_hash[word] = ''
  end
end

lemma_handler = File.open("lemmatized.csv", 'w')

lemma_hash.each_pair do |key, val|
  lemma_handler.write(key)
  lemma_handler.write(",")
  lemma_handler.write(val)
  lemma_handler.write("\n")
end
=end

#=begin
lemma_handler = File.open("lemmatized.csv", 'r')
lines = lemma_handler.readlines
lemma_handler.close
lines.map! do |line|
  line.chomp.split(/,/)
end

lines.reject! { |line| line == [] }

globalx = 0
globaly = 0
begin
lines.sort! do |x, y|
  globalx = x
  globaly = y
  x[0] <=> y[0]
end
rescue ArgumentError => e
puts e.message
print globalx
puts "\n"
print globaly
puts "\n"
end

lemma_handler = File.open("lemmatized.csv", 'w')
lines.each do |line|
  line.each do |column|
    lemma_handler.write(column)
    lemma_handler.write(",")
  end
  lemma_handler.write("\n")
end
#=end
