class StatesController < ApplicationController

  before_action :find_auction
  before_action :authorize_publisher, only: [:publish]

  def publish
    service = Auctions::PublishAuction.new(@auction)
    if service.call
      redirect_to auction_path(@auction), notice: "Auction Published"
    else
      redirect_to auction_path(@auction), alert: "can't publish the auction"
    end
  end

  def unpublish
    if @auction.unpublish!
      redirect_to auction_path(@auction), notice: "Auction Un-Published"
    else
      redirect_to auction_path(@auction), alert: "can't Un-Publish the auction"
    end
  end

  def reserve
    if @auction.reserve!
      redirect_to auction_path(@auction), notice: "Reserve Price has been met"
    else
      redirect_to auction_path(@auction), alert: "Reserve Price has not been met"
    end
  end

  def unreserve
    if @auction.unreserve!
      redirect_to auction_path(@auction), notice: "Auction Un-Reserved"
    else
      redirect_to auction_path(@auction), alert: "can't Un-Reserve the auction"
    end
  end

  def win
    if @auction.win!
      redirect_to auction_path(@auction), notice: "Someone has won the auction"
    else
      redirect_to auction_path(@auction), alert: "Someone has not won the auction"
    end
  end

  def cancel
    if @auction.cancel!
      redirect_to auction_path(@auction), notice: "Auction has been canceled"
    else
      redirect_to auction_path(@auction), alert: "Auction cannot be canceled"
    end
  end

  private

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def authorize_publisher
    unless can? :publish, @auction
        redirect_to root_path, alert: "access denied"
    end
  end
end
