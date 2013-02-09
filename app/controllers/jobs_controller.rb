#coding: utf-8

class JobsController < ApplicationController
  
  #cache setting
  caches_page :show
  cache_sweeper :job_sweeper,:only => [:update,:create, :destroy]

  # GET /tasks.json
  def index
    results=current_user.my_job_list 8 
    @todo_jobs  = results[0]
    @doing_jobs = results[1]
    @done_jobs  = results[2]
    @user_grade = current_grade current_user.id
    @group      = my_group_map
    respond_to do |format|
      #TreasureDataへの書き込み処理
      puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'index'}.to_json}"
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks.json
  def receive_task_list
    results=current_user.my_receive_job_list 8 
    @todo_jobs  = results[0]
    @doing_jobs = results[1]
    @done_jobs  = results[2]
    @user_grade = current_grade current_user.id
    @group      = my_group_map 
    respond_to do |format|
      puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'receive_task_list'}.to_json}"
      format.html # index.html.erb
    end
  end


  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @job        = Job.find(params[:id])
    @user_grade = current_grade current_user.id
    @group      = my_group_map
    respond_to do |format|
      puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'show'}.to_json}"
      format.html # show.html.erb
      format.json { render json: @job }
    end
  rescue
    render :template => 'error/job_not_found', :status => :not_found
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @job           = Job.new
    @job.user_id   = current_user.id
    @job.r_user_id = current_user.id
    @group         = my_group_map
    respond_to do |format|
      puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'new'}.to_json}"
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /tasks/1/edit
  def edit
    @job        = Job.find(params[:id])
    @user_grade = current_grade current_user.id
    @group      = my_group_map 
    puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'edit'}.to_json}"
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @job         = Job.new(job_params)
    @job.user_id = current_user.id
    @user_grade  = current_grade current_user.id
    respond_to do |format|
      if @job.save
        puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'create'}.to_json}"
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render json: @job, status: :created, location: @job }
      else
        @group = my_group_map 
        format.html { render action: "new" }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @job        = Job.find(params[:id])
    @user_grade = current_grade current_user.id
    respond_to do |format|
      if @job.update_job(job_params) 
        puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'update'}.to_json}"
        job_complete current_user.id if @job.status == 3
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { head :no_content }
      else
        @group = my_group_map 
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
      puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'destroy'}.to_json}"
      format.html { redirect_to jobs_url }
      format.json { head :no_content }
    end
  end
  
  def receive_task 
    begin
      Job.receive_job(params)
      @user_grade=current_grade current_user.id
      Pusher['taskboard_channel'].trigger('my_event',{:greeting => current_user.user_name + 'さんがタスクを引き受けてくれました'}) unless Rails.env.test?
      puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'receive_job'}.to_json}"
      redirect_to :action=>'index', :controller=>'top'
    rescue JobError => je
      raise JobError
    end
  end
  
  def finish_list
    @user_grade = current_grade current_user.id
    @tasks      = Job.where('user_id=?',current_user.id).finish.latest.paginate(page: params[:page], per_page: 20) 
    @group      = my_group_map
    puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'finish_list'}.to_json}"
  end
  
  def pending_list
    @user_grade  = current_grade current_user.id
    @tasks       = Job.where('user_id=?',current_user.id).pending.latest.paginate(page: params[:page], per_page: 20) 
    @group       = my_group_map
    puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'pending_list'}.to_json}"
  end

  def my_group_job_list
    results     = current_user.my_group_job_list(params[:group_id], 8)
    @todo_jobs  = results[0]
    @doing_jobs = results[1]
    @done_jobs  = results[2]
    @user_grade = current_grade current_user.id
    @group      = my_group_map
    puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'my_group_job_list'}.to_json}"
  end

  def group_all_jobs
    results     = Job.group_all_jobs(params[:group_id], 8)
    @todo_jobs  = results[0]
    @doing_jobs = results[1]
    @done_jobs  = results[2]
    @user_grade = current_grade current_user.id
    @group      = my_group_map
    puts "@[jobs_log.action_log] #{{'current_user'=>current_user.id, 'action'=>'group_all_jobs'}.to_json}"
  end


  private
  def job_params
    params.require(:job).permit(:title,:description,:priority,:group_id,:status,:public_flag)
  end

  def my_group_map
    @groups = current_user.my_groups
    @groups
  end

  def job_complete(user_id)
    UserGrade.set_grade user_id
  end
end
