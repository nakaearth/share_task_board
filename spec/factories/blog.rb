# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
 
  factory :test_blogger ,:class => User do|u|
    u.provider "twitter"
    u.uid "test123"
    u.name "testname"
    u.screen_name "test taorou"
    u.blog {
      FactoryGirl.build(:test_blog)
    }
  end

  factory :new_blogger ,:class => User do|u|
    u.provider "twitter"
    u.uid "newtest123"
    u.name "new_testname"
    u.screen_name "new test taorou"
  end
 
  factory :test_blog ,:class => Blog do|b|
    b.name "test blog"
    b.blog_uid "bloghoge123"
    b.description "this is test blog."
    b.blog_template {
      FactoryGirl.build(:test_blog_template)
    }   
  end

  factory :test_blog_template ,:class => BlogTemplate do |b|
    b.body "<html><head><title>test blog</title></head><body>hello world</body></html>"
    b.path "blog/bloghoge123/index"
    b.format "html"
    b.locale "ja"
    b.handler "erb"
    b.partial true
  end

end
