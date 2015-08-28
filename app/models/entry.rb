class Entry < ActiveRecord::Base

	extend FriendlyId
	friendly_id :name, use: :slugged

    mount_uploader :raw, EntryImageUploader

    validates :name, presence: {message: 'Please supply a name for your entry.'}

    has_many :lsentences
    has_many :eventscouters
    has_many :documents
    belongs_to :category
    belongs_to :cattype
    belongs_to :user
    belongs_to :badge
    belongs_to :advancement
    has_many :ratings
    has_many :comments
    has_and_belongs_to_many :programs

    before_save do
        self.build_search_text
    end

    def self.filtered(*args)
        if args[0].blank? then
            return Entry.where(:shared => true)
        else
            # all public
            Entry.where("shared = true OR (shared = false and user_id = ?)",args[0])
        end
    end

    def build_search_text
        self.searchtext = self.name
        self.searchtext += self.category.name
        self.searchtext += self.cattype.name if self.cattype != nil
        self.searchtext += self.advancement.name if self.advancement != nil
        self.searchtext += self.advancement.advlevel.name if self.advancement != nil and self.advancement.advlevel != nil
        self.searchtext += self.advancement.challenge.name if self.advancement != nil and self.advancement.challenge != nil
        self.searchtext += self.badge.name if self.badge != nil
        self.searchtext += self.description if self.description != nil
        self.searchtext += self.outcome if self.outcome != nil
        self.searchtext += self.instructions if self.instructions != nil
        self.searchtext += self.other if self.other != nil
        self.searchtext += self.resources if self.resources != nil
        self.searchtext += self.story if self.story != nil
        self.searchtext += self.song if self.song != nil
        self.searchtext += self.play if self.play != nil
        self.searchtext += self.user.name if self.user != nil
        self.searchtext.downcase!
    end

    def readmore
        return self.description[0..50] if !self.description.blank?
    end

    def self.clean_entries
        Entry.all.each do |e|
            e.destroy if e.category == nil
        end
    end

    def self.popular
#        @popular_ratings = Rating.group(:entry_id).average(:rating).sort_by(&:last).first(3)
#        @list = Array.new
#        @popular_ratings.each do |p|
#            @list << Entry.find_by_id(p[0])
#        end
#        return @list
        entry = Entry.where(:id => Comment.all.group(:entry_id).count.sort {|a,b| b[1]<=>a[1]})
        entry = entry.first[0] if !entry.blank?
        return entry if !entry.blank?
        return Entry.random
#	return Entry.all.order(:views).last(1)
    end

    def self.random
        blacklist_entries = Array.new
        blacklist_entries << Entry.recent.first.id
        blacklist_entries << Entry.featured.first.id
        entry = Entry.where(:id => Entry.where('id not in (?)', blacklist_entries).pluck(:id).sample)
    end

    def self.recent
        return Entry.last(1)
    end

    def self.featured
        return Entry.first(1)
    end

    def self.image_rebuild
        Entry.all.each do |e|
            e.raw.recreate_versions! if !e.raw.blank?
            e.save
        end
    end

    def self.involved_in(user)
        # list of entries where you commented
        @comment_entries = Comment.where(:user_id => user.id).pluck(:entry_id)
        @entries = Array.new
        # your entries with comments
        Entry.where(:user_id => user.id).each do |e|
            @entries << e.id if e.comments.count > 0
        end
        @comment_entries.uniq!
        @entries.uniq!
        return Entry.where('id in (?)',(@comment_entries + @entries).uniq)
    end

    # returs the image to use for this etnry
    def real_image
        return self.raw if !self.raw.blank?
        return self.category.image if self.raw.blank?
        return nil
    end


    # returns a short description
    def short_description
        desc = self.name
        desc += " : " + self.category.name
        desc += " : " + self.cattype.name if !self.cattype.blank?
        desc += " : " + self.advancement.name if !self.advancement.blank?
        desc += " : " + self.advancement.challenge.name if !self.advancement.blank? and !self.advancement.challenge.blank?
        return desc
    end

    def can_delete
        @candel = true
        @candel = false if self.comments.count > 0
        @candel = false if self.programs.count > 0
        return @candel

    end

    def real_time(program)
        return self.time if program.blank? and !self.time.blank?
        return self.time if !program.blank? and program.entrytime[self.id] == nil and !self.time.blank?
        return program.entrytime[self.id] if !program.blank? and program.entrytime[self.id] != nil
        return 0 if self.time.blank?
    end

    def add_scouter_entry(program,scouter)
        @eventscouter = Eventscouter.where(:program => program, :entry => self).first_or_create
        if @eventscouter.scouter == nil
            @eventscouter.scouter = Scouter.first
        end
        if scouter != nil
            @eventscouter.scouter = scouter
        end
        @eventscouter.save
    end
end
