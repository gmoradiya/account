class DisplaysController < ApplicationController
  before_action :authenticate_user!

  def daily_appointment
    start_time = Date.today.beginning_of_day
    end_time =  Date.today.end_of_day
    if params[:date].present?
      start_time = Date.parse(params[:date]).beginning_of_day
      end_time = Date.parse(params[:date]).end_of_day
    end
    @appointments = Appointment.where('date >= ? and date <= ?' , start_time, end_time).order(created_at: :asc)
  end
end
