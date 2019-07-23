class CreateAccount < ActiveRecord::Migration[5.2]
  def up
    create_table :accounts do |t|
      t.references :user, index: { unique: true }, foreign_key: true, null: false
      t.monetize :balance

      t.timestamps
    end

    change_column :accounts, :balance_cents, :integer, limit: 8
  end

  def down
    drop_table :accounts
  end
end
