class Eventscouter < ActiveRecord::Base
    belongs_to :entry
    belongs_to :program
    belongs_to :scouter
end
