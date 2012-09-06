class CreateCreditsWithdraws < ActiveRecord::Migration
  def change
    create_table :credits_withdraws do |t|
      t.references :members
      t.string :paypal_email
      t.boolean :status
      t.float :credits

      t.timestamps
    end
    add_index :credits_withdraws, :members_id
  end
end
