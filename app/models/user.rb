class User < ApplicationRecord
	has_many :articles, dependant: destroy
end
