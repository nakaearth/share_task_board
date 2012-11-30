require 'spec_helper'

describe UserGrade do
  context 'user grade up' do
    fixtures :users
    fixtures :jobs
    fixtures :grade_masters
    fixtures :user_grades

    before 'grade calc' do
      @user=User.find(2)    
      @status=UserGrade.set_grade @user.id
    end
    it "test set_grade.nil check " do
      @status.should_not == nil
    end
    it "test set_grade.grade test " do
      @status.should_not==nil
      @status.should=='up'
    end
  end
  context 'user grade up check' do
    fixtures :users
    fixtures :jobs
    fixtures :grade_masters
    fixtures :user_grades

    before 'grade calc test' do
      @user=User.find(1)    
      UserGrade.set_grade @user.id
      @status=UserGrade.set_grade @user.id
    end
    it "test set_grade.nil check " do
      @status.should_not == nil
    end
    it "test set_grade.grade test " do
      @status.should_not==nil
      @status.should=='not_up'
    end
  end
end
