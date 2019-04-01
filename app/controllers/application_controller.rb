class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_locale

  def set_locale
    cookies[:locale] = "ru" unless cookies[:locale]
    cookies[:locale] = params[:locale] if params[:locale]
    I18n.locale = cookies[:locale]
  end

  def selected_locale
    cookies[:locale] = params[:locale] if params[:locale]
    I18n.locale = cookies[:locale]
    redirect_to request.referer
  end

  def I18n.t(locale, loc = I18n.locale)
   if I18n.exists?(locale)
     super(locale, loc )
   else
     locale
   end
  end

end
