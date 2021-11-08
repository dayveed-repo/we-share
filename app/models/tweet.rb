class Tweet < ApplicationRecord
    belongs_to :user
    belongs_to :parent, class_name: 'Tweet', optional: true
    has_many   :tweets, foreign_key: :parent_id
    has_many   :likes, as: :likeable
end
