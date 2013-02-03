# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job ,:class=>Job do |j|
    j.title "MyString"
    j.description "MyText"
    j.user_id 1
    j.status 1
    j.priority 1
  end 
 
end
