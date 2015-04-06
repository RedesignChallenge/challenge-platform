# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  first_name             :string
#  last_name              :string
#  role                   :string
#  organization           :string
#  admin                  :boolean          default(FALSE)
#  ga_dimension           :string
#  title                  :string
#  video_access           :boolean          default(FALSE)
#  twitter                :string
#  avatar                 :string
#  future_participant     :boolean          default(TRUE)
#  color                  :string
#  bio                    :text
#  referrer_id            :integer
#  display_name           :string
#  avatar_option          :string           default("twitter")
#

require 'rails_helper'

describe User do

  it { is_expected.to have_and_belong_to_many(:states) }
  it { is_expected.to have_and_belong_to_many(:districts) }
  it { is_expected.to have_and_belong_to_many(:schools) }
  it { is_expected.to have_and_belong_to_many(:panels) }
  it { is_expected.to have_many(:experiences) }
  it { is_expected.to have_many(:ideas) }
  it { is_expected.to have_many(:approaches) }
  it { is_expected.to have_many(:solutions) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to belong_to(:referrer).class_name('User').with_foreign_key(:referrer_id)}
  it { is_expected.to have_many(:referrals).class_name('User').with_foreign_key(:referrer_id)}

  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_most(255) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:last_name).is_at_most(255) }
  it { is_expected.to validate_presence_of(:role) }
  it { is_expected.to validate_length_of(:role).is_at_most(255) }

  it { is_expected.to validate_length_of(:organization).is_at_most(255) }
  it { is_expected.to validate_length_of(:title).is_at_most(255) }
  it { is_expected.to validate_length_of(:twitter).is_at_most(16) }
  it { is_expected.to validate_length_of(:bio).is_at_most(2047) }

end
