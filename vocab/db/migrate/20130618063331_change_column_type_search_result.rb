class ChangeColumnTypeSearchResult < ActiveRecord::Migration
  def up
    add_column :search_results, :uniqueness_id, :string
  end

  def down
    remove_column :search_results, :uniqueness_id, :string
  end
end
