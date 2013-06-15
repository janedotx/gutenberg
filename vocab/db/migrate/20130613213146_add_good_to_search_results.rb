class AddGoodToSearchResults < ActiveRecord::Migration
  def change
    add_column :search_results, :is_good, :boolean     
  end
end
