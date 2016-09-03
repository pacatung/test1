class CreateImageables < ActiveRecord::Migration
  def change
    create_table :imageables do |t|
    	t.integer :post_id
      t.timestamps null: false
    end
  end
end
