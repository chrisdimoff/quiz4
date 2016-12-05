class AddingReferences < ActiveRecord::Migration[5.0]
  def change
    add_reference :auctions, :user, index: true
    add_reference :bids, :user, index: true
    add_reference :bids, :auction, index: true
  end
end
