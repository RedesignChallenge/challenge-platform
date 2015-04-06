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

require 'rails_helper'

describe State do

  it { is_expected.to have_many(:districts) }
  it { is_expected.to have_and_belong_to_many(:users) }

end
