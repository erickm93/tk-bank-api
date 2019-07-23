class CreateTransfer
  prepend SimpleCommand

  def initialize(opts = {})
    @source_id = opts.fetch(:source_id)
    @destination_id = opts.fetch(:destination_id)
    @value_str = opts.fetch(:value)
  end

  def call
    verify_accounts
    parse_value

    return unless errors.empty?

    ActiveRecord::Base.transaction do
      reload_accounts

      source_account.lock!
      destination_account.lock!

      validate_source_balance
      record_initial_balance

      create_transfer
      change_account_balances
    end

    @transfer
  end

  private

  def source_account
    @source_account ||= Account.find_by(id: @source_id)
  end

  def destination_account
    @destination_account ||= Account.find_by(id: @destination_id)
  end

  def verify_accounts
    errors.add(:source, 'source account not found') unless source_account
    errors.add(:destination, 'destination account not found') unless destination_account
  end

  def parse_value
    value_splited = @value_str.split('.')

    return errors.add(:value, 'value format invalid') if value_splited.size != 2

    @value = Money.new(value_splited.join)
  end

  def validate_source_balance
    source_balance = source_account.balance

    return if source_balance >= @value

    errors.add(:transfer, 'source account has insufficient funds')
    raise ActiveRecord::Rollback
  end

  def record_initial_balance
    @initial_balance = source_account.balance
  end

  def reload_accounts
    source_account.reload
    destination_account.reload
  end

  def create_transfer
    @transfer = Transfer.create!(
      initial_balance: @initial_balance,
      value: @value,
      destination: destination_account,
      source: source_account
    )
  end

  def change_account_balances
    source_account.balance -= @value
    destination_account.balance += @value
    source_account.save!
    destination_account.save!
  end
end
