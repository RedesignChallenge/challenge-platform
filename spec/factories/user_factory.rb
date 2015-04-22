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
#  notifications          :hstore           default({"comment_posted"=>"true", "comment_replied"=>"true"})
#

require 'faker'

FactoryGirl.define do
  factory :user, class: User do
    password Faker::Internet.password(12)
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    avatar Faker::Avatar.image
    role 'FactoryGirl Role'
    title Faker::Name.title
    organization Faker::Company.name

    sequence :email do |n|
      "testname#{n}@example.com"
    end
  end
  #
  # trait :with_small_avatar_file do
  #   after :create do | user |
  #     user.avatar = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/support/images/small_image.png'))
  #   end
  # end

end

