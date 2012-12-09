require 'spec_helper'

describe "tasks/index" do
  before(:each) do
    assign(:todo_jobs, [
      stub_model(Job,
        :title => "job1",
        :description => "Myjob",
        :priority   =>1,
        :status => 1
      ),
      stub_model(Job,
        :title => "job2",
        :description => "Myjob2",
        :priority   =>1,
        :status => 1
      )
    ])
    assign(:doing_jobs, [
      stub_model(Job,
        :title => "Job3",
        :description => "MyJob3 hello",
        :priority   =>1,
        :status => 2
      ),
      stub_model(Job,
        :title => "job4",
        :description => "MyJob4 hello",
        :priority   =>1,
        :status => 2
      )
    ])
    assign(:done_jobs, [
      stub_model(Job,
        :title => "Job5",
        :description => "MyJob5 hello",
        :priority   =>1,
        :status => 3
      ),
      stub_model(Job,
        :title => "job6",
        :description => "MyJob6 hello",
        :priority   =>1,
        :status =>3 
      )
    ])
  end
  it "job list view" do
    p "job list test"
  end

#  it "renders a list of tasks" do
#    render
#    # Run the generator again with the --webrat flag if you want to use webrat matchers
#    assert_select "tr>td", :text => "".to_s, :count => 2
#    assert_select "tr>td", :text => "MyText".to_s, :count => 2
#    assert_select "tr>td", :text => 1.to_s, :count => 2
#  end
end
