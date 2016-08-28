class Tweet < ApplicationRecord

	belongs_to :user
	has_one :filtered_result, dependent: :destroy
end
