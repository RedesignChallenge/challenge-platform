class String
  def true?
    return ActiveRecord::Type::Boolean.new.type_cast_from_user(self)
  end
end