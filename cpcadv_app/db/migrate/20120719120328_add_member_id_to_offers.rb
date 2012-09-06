class AddMemberIdToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :member_id, :integer
    add_index :offers, :member_id
  end
end
