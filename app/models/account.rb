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

class Account < ApplicationRecord
  belongs_to :user
  has_many :source_transfers, class_name: 'Transfer',
                              dependent: :destroy, foreign_key: :source_id, inverse_of: :source
  has_many :destination_transfers, class_name: 'Transfer',
                                   dependent: :destroy, foreign_key: :destination_id, inverse_of: :destination

  monetize :balance_cents
end
