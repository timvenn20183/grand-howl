class Advancement < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

    has_many :documents
	has_many :entries
    belongs_to :challenge
    belongs_to :advlevel

    before_save do
        create_app_name
    end

    # mobile app integration methods
    def create_app_name
        self.app_name = self.name
        self.app_name += " - "  + self.advlevel.name if !self.advlevel.blank?
        self.app_name += " - "  + self.challenge.name if !self.challenge.blank?
    end


end
