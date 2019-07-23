require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
  let(:json) { JSON.parse(response.body).with_indifferent_access }
  let(:account) { create(:account) }

  describe 'actions protection' do
    context 'without token in the Authorization header' do
      before do
        get :show, params: { id: account.id }
      end

      it 'does not authorize' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error' do
        expect(json[:errors]).to eq('Invalid token.')
      end
    end

    context 'with Authorization header set with a valid token' do
      before do
        set_jwt_header(account.user)

        get :show, params: { id: account.id }
      end

      it 'permits the access to the action' do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
