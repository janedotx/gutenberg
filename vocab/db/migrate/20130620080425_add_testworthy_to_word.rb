class AddTestworthyToWord < ActiveRecord::Migration
  def change
    add_column :words, :test_worthy, :boolean
  end
end
