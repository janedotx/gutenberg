class AddIndexToWords < ActiveRecord::Migration
  def change
    add_index :words, :headword
  end
end
