# == Schema Information
#
# Table name: accounts
#
#  id               :bigint           not null, primary key
#  balance_cents    :bigint           default(0), not null
#  balance_currency :string           default("BRL"), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_accounts_on_user_id  (user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class AccountSerializer < ActiveModel::Serializer
  attributes :id, :balance_cents
  attribute :balance

  belongs_to :user

  def balance
    object.balance.format
  end
end
