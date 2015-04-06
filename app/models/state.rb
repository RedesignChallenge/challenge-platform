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

class State < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :districts

  def self.search(search)
    limit(5).where('LOWER(name) LIKE ?', "%#{search.downcase}%") if search != ''
  end
  
end
