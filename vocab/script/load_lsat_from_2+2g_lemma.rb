#! /usr/bin/env ruby

require '../config/environment.rb'

def smush_lemmas(file, handle_type)
  f = File.open(file, handle_type)
  f_lines = f.readlines

  cur_word = Word.new
  cur_word.headword = (f_lines.shift.chomp("\n"))

  f_lines.each do |line|
    if line =~ /  /
      line.strip!
      # get rid of lines with things like "wrought -> [wreak]"
      # they seem related enough to me anyway
      line.gsub!(/ ->/, ',')
      line.gsub!(/\[/, '')
      line.gsub!(/\]/, '')
      line.gsub!(/\s/, '')
      cur_word.conjugates = line
      cur_word.save
    else
      line.strip!
      cur_word = Word.new
      cur_word.headword = line
      cur_word.save
    end
  end
end

def get_lsat_words_into_hash
  lines = File.open("../data/lemmatized.csv").readlines
  lines.each do |line|
    arr = line.split(/;/)
    next if arr.size == 0
    word = arr[0]
    big_word_hash[word]
  end
end

def mark_words_as_test_worthy
  words = Word.find(:all)
  lines = File.open("../data/lemmatized.csv").readlines
  lines.each do |line|
    arr = line.gsub(/"/, '').split(/;/)
    regex_str = !arr[1].blank? ? arr[1] : arr[0]
    puts regex_str
    regex = Regexp.new('\b' + regex_str + '\b')
      words.each do |word|
        if regex.match(word.headword)
          word.test_worthy = true
          word.save
          break
        end
      end
  end
end

def load_frequency_hash
  lines = File.open("../../2+2gfreq.txt", 'r').readlines
  hash = {}
  cur = 0
  lines.each do |l|
    if match = /\d+/.match(l)
      cur = match.to_s.to_i
      next
    end

    next if l =~ /  /

#    puts l
    hash[l.chomp] = cur
#    puts hash[l.chomp]
  end
  hash
end

def get_difficulty
  words = Word.find(:all).select { |w| w.test_worthy }
  hash =  load_frequency_hash
  words.each do |word|
    if hash[word.headword]
      word.frequency_band = hash[word.headword].to_i
      word.save
    end
  end
end
#load_frequency_hash
#=begin
#smush_lemmas
#mark_words_as_test_worthy
#get_difficulty

words = Word.find(:all).select { |w| w.test_worthy }
#words.sort! { |w, x| w.frequency_band <=> x.frequency_band }
#=begin
hash = {}

words.each do |w|
  if hash[w.frequency_band].nil?
    hash[w.frequency_band] = []
  end
  hash[w.frequency_band] << w.headword
end
#=end

hash.each_key do |key|
  f = File.open("band_#{key}", 'w')
  hash[key].each do |w|
    f.write(w)
    f.write("\n")
  end
  f.close
end
#=end
