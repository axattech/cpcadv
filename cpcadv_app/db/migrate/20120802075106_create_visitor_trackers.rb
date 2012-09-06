class CreateVisitorTrackers < ActiveRecord::Migration
  def change
    create_table :visitor_trackers do |t|
      t.string :ip
      t.text :refer_url
      t.references :offers
      t.references :members

      t.timestamps
    end
    add_index :visitor_trackers, :offers_id
    add_index :visitor_trackers, :members_id
  end
end
