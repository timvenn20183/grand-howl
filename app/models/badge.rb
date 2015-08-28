class Badge < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

	mount_uploader :image, BadgeImageUploader

    has_many :documents
	has_many :entries

    def self.image_rebuild
        Badge.all.each do |b|
            b.image.recreate_versions! if !b.image.blank?
            b.save
        end
    end

end
