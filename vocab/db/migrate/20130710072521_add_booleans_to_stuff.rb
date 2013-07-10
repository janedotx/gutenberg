class AddBooleansToStuff < ActiveRecord::Migration
  def change
    add_column :words, :number_of_results, :integer     
    add_column :books, :was_indexed, :boolean     
  end
end
