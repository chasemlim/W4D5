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

FactoryBot.define do
  factory :goal do
    
  end
end
