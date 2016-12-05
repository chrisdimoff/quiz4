class AddDefaultBidToAuction < ActiveRecord::Migration[5.0]
  def change
    change_column :auctions, :current_bid, :float, :default => 0
  end
end
