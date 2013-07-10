class AddIndexToSearchResults < ActiveRecord::Migration
  def change
    add_index :search_results, :word_id
  end
end
