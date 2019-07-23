require 'rails_helper'

RSpec.describe TransfersController, type: :controller do
  let(:json) { JSON.parse(response.body).with_indifferent_access }

  before do
    set_jwt_header(source_account.user)
  end

  describe 'POST create' do
    let(:source_account) { create(:account) }
    let(:destination_account) { create(:account) }
    let(:value) { '10.00' }
    let(:params) do
      {
        transfer: { source_id: source_account.id, destination_id: destination_account.id, value: value }
      }
    end
    let(:money_value) { Money.new(1000) }

    before do |example|
      next if example.metadata[:skip_before]

      post :create, params: params
    end

    it 'creates a transfer', :skip_before do
      expect { post :create, params: params }.to change { Transfer.count }.by(1)
    end

    it 'returns the created transfer' do
      expect_serializer_keys = %i[
        initial_balance_cents initial_balance value_cents value destination source
      ]

      expect(json[:transfer]).to_not be_empty
      expect_serializer_keys.each do |key|
        expect(json[:transfer]).to have_key(key)
      end
    end

    it 'debits the source account' do
      initial_balance = source_account.balance

      expect(source_account.reload.balance).to eq(initial_balance - money_value)
    end

    it 'credits the destination account' do
      initial_balance = destination_account.balance

      expect(destination_account.reload.balance).to eq(initial_balance + money_value)
    end

    context 'with invalid params from the request' do
      let(:value) { '10' }

      it 'return errors' do
        expect(json[:errors]).to_not be_empty
      end

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'doest not create a transfer', :skip_before do
        expect { post :create, params: params }.to change { Transfer.count }.by(0)
      end

      it 'does not debit the source account' do
        initial_balance = source_account.balance

        expect(source_account.reload.balance).to eq(initial_balance)
      end

      it 'does not credit the destination account' do
        initial_balance = destination_account.balance

        expect(destination_account.reload.balance).to eq(initial_balance)
      end
    end
  end
end
