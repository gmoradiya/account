class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :default_country, :organization, :financial_year_range, :financial_year_options, :session, :default_state
  before_action :set_financial_year
  before_action :set_organization

  def check_admin_role
    redirect_to root_path, notice: "You are not allowed" if ![ "admin", "super_admin" ].include?(current_user.role)
  end

  def check_admin_staff_role
    redirect_to root_path, notice: "You are not allowed" if ![ "admin", "super_admin", "staff" ].include?(current_user.role)
  end

  def default_country
    organization.country
  end

  def default_state
    organization.state
  end

  def organization
    Organization.find_by(id: session[:organization_id]) || current_user&.organizations&.first
  end

  def set_organization
    return if current_user.blank?
    session[:organization_id] = params[:organization_id] if params[:organization_id].present?
  end

  def set_financial_year
    return if current_user.blank?
    organization.update(financial_year: params[:financial_year]) if params[:financial_year].present?
    organization.save
  end

  def financial_year_range
    year = organization.financial_year || default_financial_year
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
