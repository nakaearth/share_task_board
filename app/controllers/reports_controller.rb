#coding: utf-8

class ReportsController < ApplicationController

  def index 
    @reports = current_user.job_report
  end

  def show
  end

  def print_out
  end
end
