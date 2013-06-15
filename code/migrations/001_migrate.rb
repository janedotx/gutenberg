#! /usr/bin/env ruby

load '/Users/jian/lsat-vocab/code/db_connect.rb'
  class CreateSearchResultsTable <  ActiveRecord::Migration
    def up
      create_table :search_results, :force => true do |t|
        t.integer :book_id
        t.integer :byte
        t.string  :snippet
        t.integer :word_id
        t.datetime :created_at
        t.datetime :updated_at
      end
    end
   
    def down
      drop_table :search_results
    end
  end

  class CreateWordsTable <  ActiveRecord::Migration
    def up
      create_table :words, :force => true do |t|
        t.string :lemma
        t.string  :conjugates
        t.datetime :created_at
        t.datetime :updated_at
      end
    end
   
    def down
      drop_table :words
    end
  end

  class CreateBooksTable <  ActiveRecord::Migration
    def up
      create_table :books, :force => true do |t|
        t.string  :location
        t.datetime :created_at
        t.datetime :updated_at
      end
    end
   
    def down
      drop_table :books
    end
  end

# to migrate:
# CreateBooksTable.new.migrate(:up)
