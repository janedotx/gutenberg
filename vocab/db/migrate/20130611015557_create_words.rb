class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.integer :frequency_band
      t.string :conjugates
      t.string :headword
      t.timestamps
    end
  end
end
