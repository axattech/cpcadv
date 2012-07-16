class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :offer_name
      t.string :offer_link
      t.text :offer_description
      t.text :offer_msg
      t.integer :offer_budget
      t.integer :offer_cr_per_click
      t.integer :offer_max_clicks_per_user
      t.date :offer_start_date
      t.date :offer_end_date
      t.boolean :offer_worldwide
      t.boolean :offer_status
      t.references :category
      t.references :country

      t.timestamps
    end
    add_index :offers, :category_id
    add_index :offers, :country_id
  end
end
