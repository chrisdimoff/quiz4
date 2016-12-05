class AddCurrentBidColumnToAuctions < ActiveRecord::Migration[5.0]
  def change
    add_column :auctions, :current_bid, :float
  end
end
