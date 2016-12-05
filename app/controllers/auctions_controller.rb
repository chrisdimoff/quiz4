class AuctionsController < ApplicationController
  def new
    @auction = Auction.new
  end

  def create
    @auction_params = params.require(:auction).permit([:title, :details, :end_date, :reserve_price])
    @auction = Auction.new @auction_params
    @auction.user = current_user
    if @auction.save
      redirect_to auction_path(@auction)
    else
      render :new
    end
  end

  def index
    @auctions = Auction.all
  end

  def show
    @auction = Auction.find(params[:id])
    @bid = Bid.new
  end
end
