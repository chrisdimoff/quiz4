class Auctions::PublishAuction
  include Virtus.model

  def initialize(auction)
    @auction = auction
  end

  def call
    @auction.publish!
  end
end
