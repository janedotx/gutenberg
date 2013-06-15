#! /usr/bin/env ruby

require '../config/environment.rb'

def load_books(words, start_id, end_id)
  ids = []
  (end_id - start_id).times { |x| ids << (start_id + x }
  books = Book.find(ids)
  books.each { |book| book.build_index(words) }
end
