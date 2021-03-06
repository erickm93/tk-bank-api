# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :text             not null
#  first_name :text             not null
#  last_name  :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  has_one :account, dependent: :nullify
end
