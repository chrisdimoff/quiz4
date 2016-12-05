class CreateAuctions < ActiveRecord::Migration[5.0]
  def change
    create_table :auctions do |t|
      t.string :aasm_state
      t.string :title
      t.text :details
      t.string :end_date
      t.float :reserve_price

      t.timestamps
    end
  end
end
