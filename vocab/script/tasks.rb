#! /usr/bin/env ruby

require '../config/environment.rb'

def index_books(words, start_id, end_id)
  ids = []
  (end_id - start_id).times { |x| ids << (start_id + x ) }
  books = Book.find(ids)
  books.each { |book| book.build_index(words) }
end

def load_books(files)
  files.each do |f|
    b = Book.new
    b.file = f
    b.save
  end
end

def delete_common_words
  lines = File.open("../../2+2gfreq.txt", 'r').readlines
  lines.each do |l|
    break if l =~ /8/
    next if l =~ /  /
    begin
      Word.find_by_headword(l.chomp).destroy
    rescue NoMethodError => e
    end
  end
end

def encode(file)
        whole_file = BOOK_FILE_ROOT + file
	s = File.open(whole_file).read
	handler = File.open(whole_file, 'w')
	s.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
	s.encode!('UTF-8', 'UTF-16')
	handler.write(s)
end

words = Word.find(:all)
books = Book.find(:all)
counter = 0
#=begin
Book.find(:all).each do |book| 
  puts book.file
  puts book.id
  puts "\n"
  book.build_index(words) 
end
#=end

