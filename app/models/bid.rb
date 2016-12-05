class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :auction

  validates :auction_id, presence: true
  validates :user_id, presence: true
  validate :amount_valid

  def amount_valid
    if amount.present? && amount < self.auction.current_bid
      errors.add(:amount, "must be higher than previous bid.")
    end
  end
end
