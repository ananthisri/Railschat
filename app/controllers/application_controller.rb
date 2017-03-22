class ApplicationController < ActionController::Base

	before_action :authenticate_user!
    protect_from_forgery with: :exception

    after_filter :user_activity

private

def user_activity
  current_user.try :touch
end

end
