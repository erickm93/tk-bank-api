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

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name

  has_one :account
end
