# == Schema Information
#
# Table name: districts
#
#  id                 :integer          not null, primary key
#  lea_id             :string
#  fipst              :string
#  stid               :string
#  name               :string
#  phone              :string
#  mail_street        :string
#  mail_city          :string
#  mail_state         :string
#  mail_zip           :string
#  mail_zip4          :string
#  location_street    :string
#  location_city      :string
#  location_state     :string
#  location_zip       :string
#  location_zip4      :string
#  _type              :string
#  union              :string
#  county_number      :string
#  county_name        :string
#  csa                :string
#  cbsa               :string
#  metmic             :string
#  ulocal             :string
#  cdcode             :string
#  latitude           :string
#  longitude          :string
#  bound              :string
#  biea               :string
#  lowest_grade       :string
#  highest_grade      :string
#  charter            :string
#  number_of_schools  :string
#  number_of_students :string
#  number_of_k12s     :string
#  number_of_members  :string
#  number_of_speceds  :string
#  number_of_ells     :string
#  state_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class DistrictSerializer < ActiveModel::Serializer
  attributes :id, :name, :location_city, :location_state

end
