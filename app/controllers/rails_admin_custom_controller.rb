class RailsAdminCustomController < ActionController::Base
  # RailsAdmin support
  include AbstractController::Helpers
  include ActionController::Flash
  include ActionController::RequestForgeryProtection
  include ActionController::MimeResponds
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionView::Layouts
  skip_before_action :verify_authenticity_token
end
