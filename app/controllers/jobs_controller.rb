#coding: utf-8

require 'pusher'

class JobsController < ApplicationController
  before_filter :authenticate_user!
  
  #cache setting
  caches_page :show
  cache_sweeper :job_sweeper,:only => [:update,:create, :destroy]

  # GET /tasks.json
  def index
    results=Job.task_lists current_user,8 
    @todo_tasks=results[0]
    @doing_tasks=results[1]
    @done_tasks=results[2]
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks.json
  def receive_task_list
    results=Job.receive_task_lists current_user,8 
    @todo_tasks=results[0]
    @doing_tasks=results[1]
    @done_tasks=results[2]
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @job = Job.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @job = Job.new
    @job.user_id = current_user.id
    @job.r_user_id=current_user.id
   
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /tasks/1/edit
  def edit
    @job = Job.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @job = Job.new(params[:job])
    @job.user_id = current_user.id
    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @job = Job.find(params[:id])

    respond_to do |format|
      if @job.update_attributes(params[:job])
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy_task
    @job = Job.find(params[:id])
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
  
  def update_status
    @task = Job.find(params[:id])
    @task.update_attribute(:status, params[:status])
  end
  
  def receive_task
    Job.receive_task(params)
    Pusher['taskboard_channel'].trigger('my_event',{:greeting => current_user.user_name + 'さんがタスクを引き受けてくれました'})
    redirect_to :action=>'index', :controller=>'top'
  end
  
  def finish_list
    @tasks=Job.finish.latest.paginate(page: params[:page], per_page: 20) 
  end
  
  def pending_list
    @tasks=Job.pending.latest.paginate(page: params[:page], per_page: 20) 
  end

  def list_for_group
    @tasks=Job.group_task_list params[:group_id]
  end
end