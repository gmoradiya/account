class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :default_country, :organization, :financial_year_range, :financial_year_options, :session, :default_state
  before_action :set_financial_year_and_organization, unless: :devise_controller?

  def check_admin_role
    redirect_to root_path, notice: "You are not allowed" if !current_user.organization_admin?(organization)
  end

  def check_admin_staff_role
    redirect_to root_path, notice: "You are not allowed" if !(current_user.organization_admin?(organization) || current_user.organization_staff?(organization))
  end

  def default_country
    organization.country
  end

  def default_state
    organization.state
  end

  def organization
    return if current_user.nil?
    return nil if current_user.organizations.blank?
    Organization.find_by(id: session[:organization_id]) || current_user&.organizations&.first
  end

  def set_financial_year_and_organization
    return if current_user.blank?
    return if params[:controller] == "organizations" && (params[:action] == "new" || params[:action] == "create")
    return redirect_to new_organization_path, alert: "Organization required to proceed further." if current_user.organizations.blank?

    if current_user.organizations.present?
      session[:organization_id] = params[:organization_id] if params[:organization_id].present?
      session[:financial_year] =  params[:financial_year] if params[:financial_year].present?
    end
  end

  def financial_year_range
    year = session[:financial_year] || default_financial_year
    start_year, end_year = year.split("-").map { |y| "20#{y}".to_i }
    start_date = Date.new(start_year, 4, 1) # 1st April
    end_date = Date.new(end_year, 3, 31)   # 31st March
    [ start_date, end_date ]
  end

  def default_financial_year
    current_year = Date.today.year
    if Date.today.month < 4
      "#{(current_year - 1) % 100}-#{current_year % 100}"
    else
      "#{current_year % 100}-#{(current_year + 1) % 100}"
    end
  end

  def financial_year_options
    current_year = Date.today.year
    years = (2020..(current_year + 1)).map { |y| "#{y - 2000}-#{(y + 1) - 2000}" }
    years.reverse
  end
end
