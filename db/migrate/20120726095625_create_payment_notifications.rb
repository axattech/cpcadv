class CreatePaymentNotifications < ActiveRecord::Migration
  def self.up
    create_table :payment_notifications do |t|
      t.text :params
      t.integer :offer_id
      t.string :status
      t.string :transaction_id
      t.datetime :purchased_at
      t.timestamps
    end
  end

  def self.down
    drop_table :payment_notifications
  end
end
