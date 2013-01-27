# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job ,:class=>Job do |j|
    j.title "MyString"
    j.description "MyText"
    j.user_id 1
    j.status 1
    j.priority 1
  end 
 
  factory :test_blogger ,:class => User do|u|
    u.provider "twitter"
    u.uid "test123"
    u.name "testname"
    u.screen_name "test taorou"
    u.blog_template {
      FactoryGirl.build(:test_blog)
    }
  end

  factory :test_blog ,:class => BlogTemplate do |b|
    b.body "<html><head><title>test blog</title></head><body>hello world</body></html>"
    b.path "blog/testuser/index"
    b.format "html"
    b.locale "ja"
    b.handler "erb"
    b.partial true
  end

end
