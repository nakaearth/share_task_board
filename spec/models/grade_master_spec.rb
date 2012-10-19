require 'spec_helper'

describe GradeMaster do
  context 'set grade grade 1' do
    fixtures :grade_masters
    before "test grade master" do
      @grade=GradeMaster.check_grade(1)
      @grade2=GradeMaster.check_grade(2)
    end
    it "test grade master" do
      @grade.id.should==1
      @grade2.id.should==1
    end 
  end
  
  context 'set grade grade 2' do
    fixtures :grade_masters
    before "test grade master" do
      @grade=GradeMaster.check_grade(10)
    end
    it "test grade master" do
      @grade.id.should==2
    end 
  end
end
