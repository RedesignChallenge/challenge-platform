# == Schema Information
#
# Table name: states
#
#  id                :integer          not null, primary key
#  fipst             :string
#  name              :string
#  mail_street       :string
#  mail_city         :string
#  mail_state        :string
#  mail_zip          :string
#  mail_zip4         :string
#  phone             :string
#  number_of_members :string
#  created_at        :datetime
#  updated_at        :datetime
#

class StateSerializer < ActiveModel::Serializer
  attributes :id, :name, :mail_state
end
