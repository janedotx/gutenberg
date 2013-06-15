#! /usr/bin/env ruby


def count_word_in_all_num(regex, lines, hash)
  lines.each do |line|
    arr = line.split(/ /)
    word = arr[1]
    frequency = arr[0].to_i
    if regex.match(word)
      hash[regex] += frequency
    end
  end
end

# this file had better be a .csv
def load_file_into_regexes(filename, regex_pos)
  lines = File.open(filename, 'r').readlines
  hash = {}
  lines.each do  |line|
    arr = line.split(/,/)
    regex = Regexp.new(arr[regex_pos])
    hash[regex] = 0
  end
  hash
end

hash = load_file_into_regexes('lsat-no-lemma-regex', 0)
lines = File.open('all.num', 'r').readlines

hash.each_key do |key|
  count_word_in_all_num(key, lines, hash)
end

f = File.open('lsat-no-lemma-regex-all-count', 'w')
hash.each_pair do |k, v|
  f.write "#{k.source},#{v}\n"
end
