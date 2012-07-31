class CreateVisitorTrackers < ActiveRecord::Migration
  def change
    create_table :visitor_trackers do |t|
      t.string :IP
      t.string :refer_url
      t.references :members

      t.timestamps
    end
    add_index :visitor_trackers, :members_id
  end
end
