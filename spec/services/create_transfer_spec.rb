require 'rails_helper'

RSpec.shared_examples 'transfer does not succeeds' do
  it 'does not create the transfer' do
    expect { command }.to change { Transfer.count }.by(0)
  end

  it 'does not debit the source account' do
    initial_balance = source_account.balance
    command

    expect(source_account.reload.balance).to eq(initial_balance)
  end

  it 'does not credit the destination account' do
    initial_balance = destination_account.balance
    command

    expect(destination_account.reload.balance).to eq(initial_balance)
  end
end

RSpec.describe CreateTransfer, type: :service do
  let(:command) { described_class.call(source_id: source_id, destination_id: destination_id, value: value) }
  let(:source_account) { create(:account) }
  let(:source_id) { source_account.id }
  let(:destination_account) { create(:account) }
  let(:destination_id) { destination_account.id }
  let(:value) { '10.00' }
  let(:money_value) { Money.new(1000) }

  describe '.call' do
    context 'with correct arguments' do
      it 'succeeds' do
        expect(command).to be_success
      end

      it 'creates the transfer' do
        expect { command }.to change { Transfer.count }.by(1)
      end

      it 'sets the correct columns on transfer' do
        initial_balance = source_account.balance
        created_transfer = command.result

        expect(created_transfer.destination_id).to eq(destination_id)
        expect(created_transfer.source_id).to eq(source_id)
        expect(created_transfer.initial_balance).to eq(initial_balance)
        expect(created_transfer.value).to eq(money_value)
      end

      it 'debits the source account' do
        initial_balance = source_account.balance
        command

        expect(source_account.reload.balance).to eq(initial_balance - money_value)
      end

      it 'credits the destination account' do
        initial_balance = destination_account.balance
        command

        expect(destination_account.reload.balance).to eq(initial_balance + money_value)
      end

      it 'returns the created transfer' do
        expect(command.result.class).to eq(Transfer)
      end

      it 'returns no erros' do
        expect(command.errors).to be_empty
      end
    end

    context 'with incorrect formatted value' do
      let(:value) { '10' }

      it 'fails' do
        expect(command).to be_failure
      end

      it 'returns incorrect value message' do
        expect(command.errors[:value]).to eq(['value format invalid'])
      end

      include_examples 'transfer does not succeeds'
    end

    context 'with inexistent source_id' do
      let(:source_id) { source_account.id + 10 }

      it 'fails' do
        expect(command).to be_failure
      end

      it 'returns inexistent source account message' do
        expect(command.errors[:source]).to eq(['source account not found'])
      end

      include_examples 'transfer does not succeeds'
    end

    context 'with inexistent destination_id' do
      let(:destination_id) { destination_account.id + 10 }

      it 'fails' do
        expect(command).to be_failure
      end

      it 'returns inexistent destination account message' do
        expect(command.errors[:destination]).to eq(['destination account not found'])
      end

      include_examples 'transfer does not succeeds'
    end

    context 'with inexistent destination_id and source_id' do
      let(:destination_id) { destination_account.id + 10 }
      let(:source_id) { source_account.id + 10 }

      it 'fails' do
        expect(command).to be_failure
      end

      it 'returns inexistent message for both' do
        expect(command.errors[:destination]).to eq(['destination account not found'])
        expect(command.errors[:source]).to eq(['source account not found'])
      end

      include_examples 'transfer does not succeeds'
    end
  end
end
