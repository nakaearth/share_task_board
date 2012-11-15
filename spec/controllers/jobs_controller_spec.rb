require 'spec_helper'

describe JobsController do
  

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TasksController. Be sure to keep this updated too.
  def valid_session
    {}
  end
  
  def valid_attribute
    {
      :title=>'test job',
      :description=>'test test test',
      :status=>'1',
      :priority=>'1'
    }
  end

  describe "GET index" do
    fixtures :users
    fixtures :jobs
    before do
      @user = User.find(1)
      controller.stub(:current_user) {@user}
      get :index 
    end
    it "login user check" do
       @user.name.should == "test name"
    end
    it "response code check" do
      response.should be_success
    end
    it "job_list" do
      assigns(:todo_jobs).should_not == nil
      assigns(:todo_jobs).size.should==2
      assigns(:doing_jobs).should_not == nil
      assigns(:doing_jobs).size.should==1
      assigns(:done_jobs).should_not == nil
      assigns(:done_jobs).size.should==1
    end
  end

#  describe "POST create" do
#    describe "with valid params" do
#      before do
#      end
#      it "assigns a newly created task as @job" do
#        post :create,{:job=>@valid_attribute},valid_session
#        assigns(:job).should be_a(Job)
#        assigns(:job).should be_persisted
#      end
#      it "redirects to the created job" do
#        post :create, {:job => valid_attributes}, valid_session
#        response.should redirect_to(Job.last)
#      end
#    end

#    describe "with invalid params" do
#      it "assigns a newly created but unsaved job as @job" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Job.any_instance.stub(:save).and_return(false)
#        post :create, {:job => {}}, valid_session
#        assigns(:job).should be_a_new(Job)
#      end
#
#      it "re-renders the 'new' template" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Job.any_instance.stub(:save).and_return(false)
#        post :create, {:job => {}}, valid_session
#        response.should render_template("new")
#      end
#    end
#  end

#  describe "PUT update" do
#    describe "with valid params" do
#      it "updates the requested task" do
#        task = Task.create! valid_attributes
#        # Assuming there are no other tasks in the database, this
#        # specifies that the Task created on the previous line
#        # receives the :update_attributes message with whatever params are
#        # submitted in the request.
#        Task.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, {:id => task.to_param, :task => {'these' => 'params'}}, valid_session
#      end
#
#      it "assigns the requested task as @task" do
#        task = Task.create! valid_attributes
#        put :update, {:id => task.to_param, :task => valid_attributes}, valid_session
#        assigns(:task).should eq(task)
#      end
#
#      it "redirects to the task" do
#        task = Task.create! valid_attributes
#        put :update, {:id => task.to_param, :task => valid_attributes}, valid_session
#        response.should redirect_to(task)
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns the task as @task" do
#        task = Task.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Task.any_instance.stub(:save).and_return(false)
#        put :update, {:id => task.to_param, :task => {}}, valid_session
#        assigns(:task).should eq(task)
#      end
#
#      it "re-renders the 'edit' template" do
#        task = Task.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Task.any_instance.stub(:save).and_return(false)
#        put :update, {:id => task.to_param, :task => {}}, valid_session
#        response.should render_template("edit")
#      end
#    end
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested task" do
#      task = Task.create! valid_attributes
#      expect {
#        delete :destroy, {:id => task.to_param}, valid_session
#      }.to change(Task, :count).by(-1)
#    end
#
#    it "redirects to the tasks list" do
#      task = Task.create! valid_attributes
#      delete :destroy, {:id => task.to_param}, valid_session
#      response.should redirect_to(tasks_url)
#    end
#  end
end
