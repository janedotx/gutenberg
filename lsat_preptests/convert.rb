#! /usr/bin/env/ ruby

=begin
files = `ls .`.split("\n")

files.each do |f|
 unless f =~ /convert\.rb/
   txt = f.chomp(".pdf") + ".txt"
   txt.gsub!(/\s/, "-")
   f.gsub!(/\s/, "\\ ")
   puts f
   puts txt
   `pdftotext #{f} #{txt}`
 end
end

=end

#`pdftotext #{"Test\ 4\ December\ 2008.pdf}`

dict = {}

files = `ls .`.split("\n")
files.each do |f|
 unless f =~ /convert\.rb/

 end
end

