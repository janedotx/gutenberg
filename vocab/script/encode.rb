#! /usr/bin/env ruby

require '../config/environment.rb'

s = File.open("/home/jian/books/books/etexts/00ws110.txt").read
handler = File.open("/home/jian/books/books/etexts/00ws110.txt", 'w')
s.encode!('UTF-16', 'UTF-8', :invalid => :replace, :replace => '')
s.encode!('UTF-8', 'UTF-16')
handler.write(s)

