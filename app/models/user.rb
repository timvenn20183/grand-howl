class User < ActiveRecord::Base

	has_many :entries
    has_many :comments
    has_many :venues
    has_many :programs
    belongs_to :venue

    serialize :options, Hash

    validates :email, uniqueness: {message: 'The supplied email address is already registered.', case_sensitive: false}
    validates :name, presence: {message: 'Please supply a name.'}
    validates :email, presence: {message: 'Please supply an email address.'}
    validates :pass, presence: {message: 'Please supply a password.'}

    after_create do
        new_user
    end

    def new_user
        UserMailer.new_user(self).deliver_now
        UserMailer.welcome(self).deliver_now
    end


end
