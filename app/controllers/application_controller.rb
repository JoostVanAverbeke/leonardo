class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  MENU_NAV_OPTIONS = %w[configuration routine].freeze
  before_action :set_active_menu_nav

  private

  def set_active_menu_nav
    if params[:menu_nav].present? && MENU_NAV_OPTIONS.include?(params[:menu_nav])
      session[:active_menu_nav] = params[:menu_nav]
    end

    @active_menu_nav = session[:active_menu_nav] || MENU_NAV_OPTIONS.first
  end
end
