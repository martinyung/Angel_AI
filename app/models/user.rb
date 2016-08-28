class User < ApplicationRecord

	has_many :tweets, dependent: :destroy
	has_one :filtered_result, through: :tweet, dependent: :destroy
	has_one :sentiment_result, dependent: :destroy
end
