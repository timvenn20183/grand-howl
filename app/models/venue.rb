class Venue < ActiveRecord::Base

    extend FriendlyId
    friendly_id :name, use: :slugged

    belongs_to :user
    belongs_to :province
    has_many :comments
    has_many :programs

    mount_uploader :image, VenueImageUploader

    def can_delete
    	@candel = true
    		@candel = false if self.comments.count > 0
    		@cendel = false if self.programs.count > 0
    	return @candel
    end

end
