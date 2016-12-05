class BidsController < ApplicationController

  before_action :authenticate_user
  before_action :find_auction, only: [:create]
  before_action :authorize_user, only: [:create]
  after_action :update_current_bid, only: [:create]
  after_action :reserve_met, only: [:create]

  def index
    @bids = Bid.where(:user_id => current_user)
  end

  def create
    bid_params = params.require(:bid).permit(:amount)
    @bid = Bid.new bid_params
    @bid.user = current_user
    @bid.auction = @auction
    respond_to do |format|
      if @bid.save
        format.js { render :create_bid_success }
        format.html { redirect_to auction_path(@auction), notice: 'bid created' }
      else
        format.js { render :create_bid_failure }
        format.html { redirect_to auction_path(@auction) }
      end
    end
  end

  private

  def authorize_user
    unless can? :bid, @auction
      redirect_to root_path, alert: "access denied"
    end
  end

  def find_auction
    @auction = Auction.find params[:auction_id]
  end

  def update_current_bid
    if @bid.amount > @auction.current_bid
      @auction.update_attribute(:current_bid, @bid.amount)
      @auction.save
    end
  end

  def reserve_met
    if (@auction.current_bid > @auction.reserve_price) && (@auction.aasm_state == "published")
      @auction.reserve!
    end
  end

end
