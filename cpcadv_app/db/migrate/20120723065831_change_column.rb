class ChangeColumn < ActiveRecord::Migration
  def up
    change_table :offers do |t|
     t.change :offer_start_date, :string
    end
  end

  def down
  end
end
