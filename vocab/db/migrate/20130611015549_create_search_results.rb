class CreateSearchResults < ActiveRecord::Migration
  def change
    create_table :search_results do |t|
      t.integer :book_id
      t.integer :byte_location
      t.string  :snippet
      t.integer :word_id
      t.timestamps
    end
  end
end
