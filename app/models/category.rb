class Category < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

    mount_uploader :image, CategoryImageUploader

    has_many :documents
    has_many :entries
    has_many :cattypes

    serialize :options, Hash

    scope :visable, lambda {self.where(:special => false)}

    def self.image_rebuild
        Category.all.each do |c|
            c.image.recreate_versions! if !c.image.blank?
            c.save
        end
    end

end
