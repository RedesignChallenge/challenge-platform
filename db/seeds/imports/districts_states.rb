@districts_by_state = District.all.group_by(&:fipst)

@districts_by_state.each do |fipst, districts|
  state = State.find_by(fipst: fipst)
  districts.each{ |district| district.update_column(:state_id, state.id) } if state.present?
end