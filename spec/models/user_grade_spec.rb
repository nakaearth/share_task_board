require 'spec_helper'

describe UserGrade do
  context 'user grade up' do
    fixtures :users
#    fixtures :grade_masters

    before 'grade calc' do
      @user=User.find(1)    
      grade_map=UserGrade.set_grade @user.id
      @user_grade=grade_map[:user_grade]
      @status=grade_map[:status]
      @next_count=grade_map[:next_count]
    end
    it "test set_grade.nil check " do
      @user_grade.should_not == nil
    end
    it "test set_grade.grade test " do
      @user_grade.grade_master.level.should == 1
      @status.should_not==nil
      #@status.should=='up'
      @next_count.should==8
    end
  end
  context 'user grade up check' do
    fixtures :users
#    fixtures :grade_masters

    before 'grade calc test' do
      @user=User.find(1)    
      UserGrade.set_grade @user.id
      grade_map=UserGrade.set_grade @user.id
      @user_grade=grade_map[:user_grade]
      @status=grade_map[:status]
      @next_count=grade_map[:next_count]
    end
    it "test set_grade.nil check " do
      @user_grade.should_not == nil
    end
    it "test set_grade.grade test " do
      @user_grade.grade_master.level.should == 1
      @status.should_not==nil
      @status.should=='not_up'
      @next_count.should==8
    end
  end
end
