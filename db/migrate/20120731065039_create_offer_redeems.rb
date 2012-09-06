class CreateOfferRedeems < ActiveRecord::Migration
  def change
    create_table :offer_redeems do |t|
      t.references :offers
      t.references :members
      t.references :visitor_trackers
      t.float :amount

      t.timestamps
    end
    add_index :offer_redeems, :offers_id
    add_index :offer_redeems, :members_id
    add_index :offer_redeems, :visitor_trackers_id
  end
end
