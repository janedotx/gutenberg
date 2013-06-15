#! /usr/bin/env ruby

# correlate lsat frequency with lemma frequency

#=begin
f = File.open('count', 'r')
f_lines = f.readlines
f.close

regexps = []

frequency_hash = {}
f_lines.each_with_index do |line, index|
  arr = line.split(/,/)
  regex = Regexp.new("^" + arr[0])
  frequency_hash[regex] = [arr[2].chomp]
end


lemmas = []
f = File.open('lemma.num', 'r')
lines = f.readlines
f.close

lines.each_with_index do |line, index|
  arr = line.split(/\s/)
  frequency_hash.each_key do |regexp|
    if arr[2].match(regexp)
      #lemmas << [regexp[0], regexp[1], index]
      # match absolute lsat frequency against absolute real world lemma frequency
      cur = frequency_hash[regexp]
      if cur.size > 1
        total = frequency_hash[regexp][1] + arr[1].to_i
        frequency_hash[regexp][1] = total
      else
        frequency_hash[regexp] << arr[1].to_i
      end
    end
  end
end

=begin
f= File.open('lemma-lsat-wordless', 'w')
frequency_hash.each_pair do |regex, frequencies|
  f.write("#{frequencies[0]} #{frequencies[1]}")
  f.write("\n")
end
f.close
#=end


=begin
f= File.open('lemma-lsat-num-only-short', 'w')
lemmas.each do |lemma|
  f.write("#{lemma[1]} #{lemma[2]}") unless lemma[1] < 275
  f.write("\n")
end
f.close
=end

=begin
all_hash = {}
f = File.open('all.num', 'r')
lines = f.readlines
lines.each_with_index do |line, index|
  arr = line.split(/\s/)
  all_hash[Regexp.new(arr[1])] = index
end

f.close

f = File.open('get_all_frequency', 'w')
frequency_hash.each_pair do |key, val|
  f.write()
end
=end

=begin
f= File.open('lsat-no-lemma', 'w')
g = File.open('lsat-yes-lemma', 'w')
frequency_hash.each_pair do |regex, frequencies|
  if frequencies[1]
    g.write("#{regex.source[1...regex.source.size]},#{frequencies[0]},#{frequencies[1]}")
    g.write("\n")
  else
    f.write("#{regex.source[1...regex.source.size]},#{frequencies[0]}")
    f.write("\n")
  end
end
f.close
g.close
=end

tally = 0
f = File.open('lsat-yes-lemma-wordless', 'w')
frequency_hash.each_pair do |regex, frequencies|
  if frequencies[1]
    f.write("#{tally} #{frequencies[0]} #{frequencies[1]}")
    f.write("\n")
    tally += 1
  end
end
f.close
