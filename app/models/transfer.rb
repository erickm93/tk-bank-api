# == Schema Information
#
# Table name: transfers
#
#  id                       :bigint           not null, primary key
#  initial_balance_cents    :bigint           default(0), not null
#  initial_balance_currency :string           default("BRL"), not null
#  value_cents              :bigint           default(0), not null
#  value_currency           :string           default("BRL"), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  destination_id           :bigint           not null
#  source_id                :bigint           not null
#
# Indexes
#
#  index_transfers_on_destination_id  (destination_id)
#  index_transfers_on_source_id       (source_id)
#
# Foreign Keys
#
#  fk_rails_...  (destination_id => accounts.id)
#  fk_rails_...  (source_id => accounts.id)
#

class Transfer < ApplicationRecord
  belongs_to :source, class_name: 'Account'
  belongs_to :destination, class_name: 'Account'
end
