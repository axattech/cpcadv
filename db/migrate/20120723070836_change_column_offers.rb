class ChangeColumnOffers < ActiveRecord::Migration
  def up
     def up
    change_table :offers do |t|
     t.change :offer_start_date, :string
     t.change :offer_end_date, :string
     
    end
  end

  def down
  end
  end

  def down
  end
end
