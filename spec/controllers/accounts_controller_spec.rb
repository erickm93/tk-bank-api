require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:json) { JSON.parse(response.body).with_indifferent_access }

  before do
    set_jwt_header(account.user)
  end

  describe 'GET show' do
    let(:account) { create(:account) }
    let(:account_id) { account.id }
    let(:params) { { id: account_id } }

    before do
      get :show, params: params
    end

    it 'returns http status ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the requested account' do
      expect(json[:account][:id]).to eq(account.id)
    end

    it 'returns the balance from the account' do
      expect(json[:account][:balance]).to eq(account.balance.format)
    end

    context 'with an inexistent id' do
      let(:account_id) { account.id + 1 }

      it 'returns an error' do
        expect(json[:errors]).to_not be_empty
        expect(json[:errors][:account]).to eq('Account not found.')
      end

      it 'returns http status not_found' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'with include_user param' do
      let(:params) { { id: account_id, include_user: true } }

      it 'returns the account user included in the response' do
        expect(json[:account][:user]).to_not be_empty
        expect(json[:account][:user][:id]).to eq(account.user_id)
      end
    end
  end
end
