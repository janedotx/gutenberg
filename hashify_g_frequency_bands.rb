#! /usr/bin/env ruby

def hashify_g_frequency_bands(lines)
  headwords = 0
  dict = {}
  band_tally = {}
  current_band = 0
  lines.each do |line|
    # indicates a new frequency band
    if line =~ /----/
      current_band = line.match(/\d+/)[0].to_i
      band_tally[current_band] = 0
    elsif line =~ /^    /
      line.split(/,/).each do |word|
        dict[word.gsub(/\s/, '')] = current_band
      end
    else
      headwords += 1
      word = line.split(/\s/)[0].gsub(/\s/, '')
      dict[word] = current_band
      band_tally[current_band] += 1
    end
  end

  f = File.open("2+2gf_band_tally", 'w')
  band_tally.to_a.each do |tally|
    f.write(tally[0].to_s + " " + tally[1].to_s + "\n")
  end
  f.close
  [dict, band_tally]
end

def calculate_rank_with_bands(band_tally, band)
  return 0 if band == 0
  rank = 0
  (band - 1).times do |x|
    rank += band_tally[x + 1]
  end
  rank += band_tally[band]/2
  rank
end

result = hashify_g_frequency_bands(File.open('2+2gfreq.txt', 'r').readlines)
dict = result[0]
band_tally = result[1]

lines = File.open('lemmatized.csv', 'r').readlines
lsat_frequencies = []

lines.each do |line|
  next if line == ";;\n"
  
  arr = line.split(/;/)
  word = arr[0].gsub(/\"/, '')

  band = dict[word].to_i

  lsat_frequencies << [word, band, calculate_rank_with_bands(band_tally, band)]
end

sorted = lsat_frequencies.sort { |a, b| a[1] <=> b[1] }

f = File.open('lsat-frequency-bands', 'w')

sorted.each do |x|
  f.write(x.join(", ") + "\n")
end

f = File.open('2+2gf_lemma_ranking', 'w')
dict.each_pair do |key, val|
  f.write([key, val, calculate_rank_with_bands(band_tally, val)].join(", ") + "\n")
end
