class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :token
      t.string :data
      t.timestamps null: false
    end

    create_table :audiences_clients, id: false do |t|
  		t.references :audience
      t.references :client
	  end
  end
end
