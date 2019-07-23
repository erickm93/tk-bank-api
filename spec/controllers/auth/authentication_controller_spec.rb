require 'rails_helper'

RSpec.describe Auth::AuthenticationController, type: :controller do
  let(:json) { JSON.parse(response.body).with_indifferent_access }

  describe 'POST login' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:params) do
      { user: { email: email } }
    end

    before do
      post :login, params: params
    end

    it 'returns http status ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the generated token' do
      expect(json[:token]).to_not be_empty
    end

    context 'with an invalid email' do
      let(:email) { 'notvalid@email.com' }

      it 'returns http status unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns errors' do
        expect(json[:errors]).to_not be_empty
      end

      it 'returns authentication error message' do
        expect(json[:errors]).to eq(['Authentication error, check your credentials.'])
      end
    end
  end
end
