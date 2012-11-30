#coding: utf-8

require 'pusher'

class UserGrade < ActiveRecord::Base
  attr_accessible :user_grade, :user_id
  belongs_to :grade_master

  def self.set_grade(user_id)
    begin
      count=Job.where('user_id=?',user_id).where('status >= ?',3).count(:id)
      result_map =GradeMaster.check_grade(count)
      @grade = result_map[:grade_master]
      next_count= result_map[:next_count]
      UserGrade.where('user_id=?',user_id).first_or_create do |u_grade|
        u_grade.user_id=user_id
        u_grade.grade_master=@grade
      end
      @user_grade=UserGrade.where('user_id=?',user_id).includes(:grade_master).first
      unless @grade.level == @user_grade.grade_master.level
        @user_grade.grade_master=@grade
        @user_grade.save
        @status='up'
      else
        @status='not_up'
      end
      self.send_push(user_id, @status, next_count)
      @status
    rescue =>e
      puts "SET GRADE ERROR.#{e.message}"
      @status='not_up'
    end
  end

  private
  def self.send_push(user_id, status,next_count)
    if status =='up'
      user=User.find(user_id)
      Pusher['taskboard_channel'].trigger('my_event',{:message => user.name + 'さんのレベルがアップしました。次のレベルまでに' + next_count.to_s + "個必要です"}) unless Rails.env.test?
    else
      Pusher['taskboard_channel'].trigger('my_event',{:message => '次のレベルまでに' + next_count.to_s + "個必要です"}) unless Rails.env.test?
    end 
  end
end
