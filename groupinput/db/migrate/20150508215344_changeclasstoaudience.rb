class Changeclasstoaudience < ActiveRecord::Migration
  def change
  	rename_table :courses, :audiences
  end
end
