class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :username
      t.string :email
      t.string :password
      t.integer :country_id
      t.string :provider
      t.boolean :status

      t.timestamps
    end
  end
end
