#coding: utf-8

class ReportsController < ApplicationController

  def index 
    @report_date = Time.now
  end

  def calculate_job_count
    @report_date=Time.mktime(params[:date][:year],params[:date][:month],params[:date][:day],0,0)
    #ここに日付分の集計処理を記述・・・。
    @report_map = current_user.job_report
  end

  def print_out
    @report_map = current_user.job_report
  end
end
