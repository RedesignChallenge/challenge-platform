# == Schema Information
#
# Table name: steps
#
#  id             :integer          not null, primary key
#  display_order  :integer
#  title          :string
#  description    :text
#  steppable_id   :integer
#  steppable_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

class Step < ActiveRecord::Base
  default_scope { order('display_order asc, id asc') }

  belongs_to :steppable, polymorphic: true

  validates :description, presence: true

end
