class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper_method :current_user_name, :is_admin_user, :is_logged_in, :current_user, :current_program, :clear_current_program, :is_editing_program, :encrypt, :set_user_view_style, :set_user_current_program, :entry_time_options, :per_page

 	def authenticate_admin
 		redirect_to '/login' if session[:user] == nil
 		redirect_to '/login' if is_logged_in and !is_admin_user
	end

	def authenticate_user
		redirect_to '/login' if session[:user] == nil
 	end

	def current_user_name
		user = User.where(:id => session[:user]).first
		return "Unknown" if user.blank?
		return user.name.split(" ").first if !user.blank?
	end

	def current_user
		return User.where(:id => session[:user]).first
	end

	def is_logged_in
		return true if session[:user] != nil
		return false
	end

	def is_admin_user
		return true if is_logged_in and User.where(:id => session[:user]).first.level > 0
		return false
	end

    def current_program
        return nil if !is_logged_in and session[:program] == nil
        program = Program.find_by_id(session[:program])
        return program
    end

    def clear_current_program
        session[:program] = nil
    end

    def is_editing_program
        return true if current_program != nil
        return false
    end

    def encrypt(value)
        begin
            secret = Digest::SHA1.hexdigest('gh')
            code = ActiveSupport::MessageEncryptor.new(secret)
            return code.encrypt_and_sign(value.to_s)
        rescue
            return nil
        end
    end

    def decrypt(value)
        begin
            secret = Digest::SHA1.hexdigest('gh')
            code = ActiveSupport::MessageEncryptor.new(secret)
            return code.decrypt_and_verify(value.to_s)
        rescue
            return nil
        end
    end

    def set_user_view_style(style)
        if !current_user.blank? then
            user = User.where(:id => session[:user]).first
            user.options[:view_style] = style
            user.save
        end
    end

    def set_user_current_program
        if !current_user.blank? then
            user = User.where(:id => session[:user]).first
            user.options[:program] = session[:program]
            user.save
        end
    end

    def entry_time_options
        time_options = Array.new
        time_options = (0..25).map {|i| [i,i]}
        time_options += (30..120).step(5).map {|i| [i,i]}
        return time_options
    end

    def per_page
        if session[:view_style] == 'table' then
            return 30
        else
            return 12
        end
    end

end
