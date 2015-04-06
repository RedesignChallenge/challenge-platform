# == Schema Information
#
# Table name: schools
#
#  id              :integer          not null, primary key
#  nces_id         :string
#  fipst           :string
#  lea_id          :string
#  school_id       :string
#  stid            :string
#  sea_school_id   :string
#  lea_name        :string
#  name            :string
#  phone           :string
#  mail_street     :string
#  mail_city       :string
#  mail_state      :string
#  mail_zip        :string
#  mail_zip4       :string
#  location_street :string
#  location_city   :string
#  location_state  :string
#  location_zip    :string
#  location_zip4   :string
#  _type           :string
#  status          :string
#  ulocal          :string
#  latitude        :string
#  longitude       :string
#  county_number   :string
#  county_name     :string
#  cdcode          :string
#  ft_teachers     :string
#  lowest_grade    :string
#  highest_grade   :string
#  level           :string
#  title1          :string
#  stitle1         :string
#  magnet          :string
#  charter         :string
#  shared          :string
#  bies            :string
#  district_id     :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_city, :location_state

end
