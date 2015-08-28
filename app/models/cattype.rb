class Cattype < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :entries
    belongs_to :category

end
