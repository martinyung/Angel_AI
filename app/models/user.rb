class User < ApplicationRecord

	has_many :tweets
	has_one :filtered_result, :through => :tweet


end
