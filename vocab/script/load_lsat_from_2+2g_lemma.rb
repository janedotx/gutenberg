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
    regex_str = !arr[1].nil? ? arr[1] : arr[0]
    regex = Regex.new(regex_str)
      words.each do |word|
        if regex.match(word.headword)
          word.test_worthy = true
          word.save
          break
        end
      end
  end
end
