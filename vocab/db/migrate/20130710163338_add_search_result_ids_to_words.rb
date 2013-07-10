class AddSearchResultIdsToWords < ActiveRecord::Migration
  def change
    add_column :words, :search_result_ids, :binary
  end
end
