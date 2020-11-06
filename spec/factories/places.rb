# == Schema Information
#
# Table name: places
#
#  id         :bigint           not null, primary key
#  coordinate :geography        not null, point, 4326
#  local      :string           not null
#  name       :string
#  place_type :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_places_on_coordinate            (coordinate) USING gist
#  index_places_on_local                 (local)
#  index_places_on_local_and_coordinate  (local,coordinate) UNIQUE
#
FactoryBot.define do
  factory :place do
    local { "MyString" }
    coordinate { "" }
    name { "MyString" }
    place_type { "MyString" }
  end
end
