# == Schema Information
#
# Table name: goals
#
#  id           :bigint(8)        not null, primary key
#  goal_title   :string           not null
#  goal_details :text
#  user_id      :integer          not null
#  private      :boolean          default(FALSE)
#  completed    :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Goal < ApplicationRecord
  validates :goal_title, :user_id, presence: true
  
  belongs_to :user,
    foreign_key: :user_id,
    class_name: :User
end
