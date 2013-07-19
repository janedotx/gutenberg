class AddGoodSearchResultIdsToWords < ActiveRecord::Migration
  def change
    add_column :words, :good_search_result_ids, :binary
  end
end
