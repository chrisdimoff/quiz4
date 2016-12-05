require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do
  let(:user) { create(:user) }

  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it 'instantiates a new auction object' do
      get :new
      # assigns(:campaign) will test for an instance varialbe: @campaign
      # be_a_new(Campaign) will match that the instance variable is of class
      #                    Campaign and it's a non-persisted object
      expect(assigns(:auction)).to be_a_new(Auction)
    end
  end

  describe '#create' do
    context 'with user signed in' do
      before { request.session[:user_id] = user.id }
      def valid_auction
        post :create, params: { auction: attributes_for(:auction) }
      end

      it 'adds an auction' do
        c1 = Auction.count
        valid_auction
        c2 = Auction.count
        expect(c2).to eq(c1 + 1)
      end
      it 'redirects to the show page' do
        valid_auction
        expect(response).to redirect_to(auction_path(Auction.last))
      end
    end
  end
end
