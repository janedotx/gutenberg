#! /usr/bin/env ruby

require 'set'
require 'active_record'
require 'sqlite3'

load 'search_classes.rb'

def smush_lemmas(file, handle_type)
  big_word_hash = {}
  f = File.open(file, handle_type)
  f_lines = f.readlines

  cur_word = Word.new(f_lines.shift.chomp("\n"))
  big_word_hash[cur_word.lemma] = cur_word

  f_lines.each do |line|
    line.strip!
    if line =~ /   /
      # get rid of lines with things like "wrought -> [wreak]"
      # they seem related enough to me anyway
      line.gsub!(/ ->/, ',')
      line.gsub!(/\[/, '')
      line.gsub!(/\]/, '')
      arr = line.split(/, /)
      cur_word.conjugates = arr
    else
      cur_word = Word.new(line)
      big_word_hash[cur_word.lemma] = cur_word
    end
  end
end

def get_lsat_words_into_hash
  lines = File.open("lemmatized.csv").readlines
  lines.each do |line|
    arr = line.split(/;/)
    next if arr.size == 0
    word = arr[0]
    big_word_hash[word]
  end
end

smush_lemmas("2+2lemma.txt.short", 'w')
