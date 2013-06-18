class AddUniquenessColumnToSearchResult < ActiveRecord::Migration
  def change
    add_column :search_results, :unique_hash, :integer     
  end
end
