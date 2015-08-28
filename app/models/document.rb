class Document < ActiveRecord::Base

    mount_uploader :raw, DocumentUploader

    belongs_to :entry
    belongs_to :badge
    belongs_to :advancement
    belongs_to :category
    belongs_to :program

end
