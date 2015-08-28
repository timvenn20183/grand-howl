class Program < ActiveRecord::Base

		extend FriendlyId
		friendly_id :name, use: :slugged

        serialize :entryorder, Hash
        serialize :entrytime, Hash
        serialize :daybreaks, Hash

		attr_accessor :entry_tokens

    	mount_uploader :image, ProgramImageUploader

        has_many :lsentences
		belongs_to :user
		belongs_to :venue
		has_many :documents
		has_many :comments
		has_and_belongs_to_many :entries

		validates :name, presence: {message: 'Please supply a name for your program.'}

		scope :for_all, lambda {Program.where(:shared => true)}

		# helper methods

		public

		def self.programs_for_user(user)
			return user.programs
		end

		def real_start_time
			return self.start_time.to_time if self.start_time != nil
			return Time.now
		end

		def real_end_time
			return self.end_time.to_time if self.end_time != nil
            return self.real_start_time + 120.minutes
		end

		def actual_end_time
			return self.real_start_time + self.runtime.minutes if self.runtime != nil
			return self.real_end_time
		end

		def can_delete
			@candel = true
    		@candel = false if self.comments.count > 0
    		return @candel
		end

		def entry_tokens=(ids)
        	self.entry_ids = ids.split(",")
    	end

        def build_entry_order
            if self.entryorder.blank? then
                self.entries.each do |e|
                    self.entryorder[e.id] = self.entries.index(e)
                end
            else
                temp = self.entries.pluck(:id)
                order_hash = Hash.new
                temp.each do |e|
                    order_hash[e] = self.entryorder[e] if self.entryorder[e] != nil
                    order_hash[e] = self.next_entry_order_id if self.entryorder[e] == nil
                end
                # we have the new hash lets sort and rebuild
                self.entryorder = order_hash
                temp2 = self.entryorder.sort_by {|_key, value|value}
                count = 0
                temp2.each do |e|
                    if temp.include?(e[0]) then
                        self.entryorder[e[0]] = count
                        count += 1
                    end
                end
            end
            self.save
        end

        def ordered_entries
            entries = Array.new
            self.entryorder.sort_by {|_key, value|value}.each do |e|
                e =  Entry.find_by_id(e[0].to_i)
                entries << e
                e.add_scouter_entry(self,nil)
            end
            return entries
        end

        # move entry down in the order
        # still required range checking
        def order_entry_down(i)
            temp = self.entryorder.sort_by {|_key, value|value}
            entry_current_order = temp[i][1]
            entry_new_order = temp[i+1][1]
            self.entryorder[temp[i][0]] = entry_new_order
            self.entryorder[temp[i+1][0]] = entry_current_order
            self.save
            self.build_entry_order
        end

        def order_entry_up(i)
            temp = self.entryorder.sort_by {|_key, value|value}
            entry_current_order = temp[i][1]
            entry_new_order = temp[i-1][1]
            self.entryorder[temp[i][0]] = entry_new_order
            self.entryorder[temp[i-1][0]] = entry_current_order
            self.save
            self.build_entry_order
        end

        def next_entry_order_id
            temp = self.entryorder.sort_by {|_key, value|value}
            return temp.last[1]+1 if !temp.blank?
            return 0
        end

        def running_days
            return (self.real_end_time.to_date - self.real_start_time.to_date).to_i+1
        end

        def create_day_breaks
            # do we need any breaks
            if self.running_days > 1 then
                # we need to remember to remove entries that are no longer required
                temp_daybreaks = self.daybreaks
                # clear all entries
                self.daybreaks = nil
                # we need to add one for 8am on each day
                time_line = self.real_start_time
                (2..self.running_days).each do |day|
                    time_line = time_line + 1.day
                    # is there already an entry for 1 in daybreaks ?
                    # can we find the day
                    if temp_daybreaks[day] == nil then
                        # we need to add it and by default it will be 7am the next day
                        self.daybreaks[day] = time_line.change({ hour: 7, min: 0, sec: 0 })
                    else
                        self.daybreaks[day] = temp_daybreaks[day]
                    end
                end
            else
                self.daybreaks = nil
            end
                self.save
        end

end
