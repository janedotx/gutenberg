#! /usr/bin/env ruby

require '../config/environment.rb'

def index_books(words, start_id, end_id)
  ids = []
  (end_id - start_id).times { |x| ids << (start_id + x }
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
    if l =~ /9/
      break
    end
    next if l =~ /  /
    begin
      Word.find_by_headword(l.chomp).destroy
    rescue NoMethodError => e
    end
  end
end

delete_common_words
