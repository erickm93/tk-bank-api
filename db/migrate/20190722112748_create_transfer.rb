class CreateTransfer < ActiveRecord::Migration[5.2]
  def change
    create_table :transfers do |t|
      t.references :source, index: true, foreign_key: { to_table: :accounts }, null: false
      t.references :destination, index: true, foreign_key: { to_table: :accounts }, null: false
      t.monetize :value
      t.monetize :initial_balance

      t.timestamps
    end

    change_column :transfers, :value_cents, :integer, limit: 8
    change_column :transfers, :initial_balance_cents, :integer, limit: 8
  end
end
