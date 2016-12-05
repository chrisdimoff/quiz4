require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user) { create(:user) }
  let(:auction) { create(:auction) }

  describe '#create' do
    context 'with user signed in' do
      before { request.session[:user_id] = user.id }

      it 'adds a bid' do
        c1 = Bid.count
        create(:bid, user_id: user.id, auction_id: auction.id)
        c2 = Bid.count
        expect(c2).to eq(c1 + 1)
      end

      it 'associates the user properly' do
        create(:bid, user_id: user.id, auction_id: auction.id)
        @user = Bid.last.user
        expect(@user).to eq(user)
      end
    end
  end
end
