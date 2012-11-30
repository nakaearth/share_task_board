require 'spec_helper'

describe GradeMaster do
  context 'set grade grade 1' do
    fixtures :grade_masters
    before "test grade master" do
      @grade=GradeMaster.check_grade(1)
      @grade2=GradeMaster.check_grade(2)
    end
    it "test grade master" do
      grade_master=@grade[:grade_master]
      grade_master2=@grade2[:grade_master]
      grade_master.id.should==1
      grade_master2.id.should==2
    end 
  end
  
  context 'set grade grade 2' do
    fixtures :grade_masters
    before "test grade master" do
      @grade=GradeMaster.check_grade(10)
    end
    it "test grade master" do
      (@grade[:grade_master]).id.should==2
    end 
  end
end
