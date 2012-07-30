class CreateTopupPayments < ActiveRecord::Migration
  def change
    create_table :topup_payments do |t|
      t.references :offers
      t.integer :amount

      t.timestamps
    end
    add_index :topup_payments, :offers_id
  end
end
