FactoryGirl.define do
  factory :job1 ,:class=>Job do|j|
    j.title "myTest Job"
    j.description "test tes testtest "
    j.status 1
    j.priority 1
  end
  factory :current_user ,:class=>User do|f|
    f.uid "AAABBBCCCDDD123"
    f.name "TestUserName"
    f.screen_name "test TEST"
    f.jobs [FactoryGirl.build(:job1),FactoryGirl.build(:job1)]
  end 
end 
