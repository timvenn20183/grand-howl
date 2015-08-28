class Comment < ActiveRecord::Base

        belongs_to :entry
        belongs_to :user
        belongs_to :venue
        belongs_to :program

        after_create do
                email_comment
        end

        after_save do
                update_entry
        end

        def email_comment
              #  ContactMailer.send_comment(self)
        end

        def update_entry
            if !self.entry.blank?
                entry = self.entry
                entry.save
            end
        end

end
