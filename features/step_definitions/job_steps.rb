#encoding: utf-8
前提 /^次の"(.*?)"レコードがある$/ do |factory, table|
  table.hashes.each do |hash|
    FactoryGirl.create(factory, hash)
  end 
end
 
前提 /^"(.*?)"ページを表示している$/ do |addr|
  visit addr
end
 
もし /^"(.*?)"ページを表示する$/ do |addr|
  visit addr
end
 
もし /^"(.*?)"リンクをクリックする$/ do |link|
  click_link link
end
 
もし /^"(.*?)"ボタンをクリックする$/ do |link|
  click_button link
end
ならば /^"(.*?)"ページを表示していること$/ do |path|
  current_path.should == path
end
 
ならば /^"(.*?)"と表示されていること$/ do |content|
  page.should have_content content
end
 
ならば /^"(.*?)"と表示されていないこと$/ do |content|
  page.should have_no_content content
end
