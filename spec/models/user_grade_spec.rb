require 'spec_helper'

describe UserGrade do
  context 'user grade up' do
    fixtures :users
    fixtures :grade_masters

    before 'grade calc' do
      @user=User.find(1)    
      @user_grade=UserGrade.set_grade @user.id
    end
    it "test set_grade.nil check " do
      @user_grade.should_not == nil
    end
    it "test set_grade.grade test " do
      @user_grade.grade_master.id.should == 1
    end
  end
end
