# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job do
    title "MyString"
    description "MyText"
    user_id 1
    status 1
    priority 1
  end
end
