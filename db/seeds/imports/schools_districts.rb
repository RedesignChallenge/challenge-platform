@schools_by_district = School.all.group_by(&:lea_id)

@schools_by_district.each do |lea_id, schools|
  district = District.find_by(lea_id: lea_id)
  schools.each{ |school| school.update_column(:district_id, district.id) } if district.present?
end