#coding: utf-8

class JobsController < ApplicationController
  
  #cache setting
  caches_page :show
  cache_sweeper :job_sweeper,:only => [:update,:create, :destroy]

  # GET /tasks.json
  def index
    results=current_user.my_job_list 8 
    @todo_jobs=results[0]
    @doing_jobs=results[1]
    @done_jobs=results[2]
    @user_grade=current_grade current_user.id
    @group=my_group_map current_user.id
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks.json
  def receive_task_list
    results=current_user.my_receive_job_list 8 
    @todo_jobs=results[0]
    @doing_jobs=results[1]
    @done_jobs=results[2]
    @user_grade=current_grade current_user.id
    @group=my_group_map current_user.id
    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @job = Job.find(params[:id])
    @user_grade=current_grade current_user.id
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @job }
    end
  rescue
    render :template => 'error/job_not_found', :status => :not_found
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @job = Job.new
    @job.user_id = current_user.id
    @job.r_user_id=current_user.id
    @group=my_group_map current_user.id
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @job }
    end
  end

  # GET /tasks/1/edit
  def edit
    @job = Job.find(params[:id])
    @user_grade=current_grade current_user.id
    @group=my_group_map current_user.id
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @job = Job.new(job_params)
    @job.user_id = current_user.id
    @user_grade=current_grade current_user.id
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


  def update
    @job = Job.find(params[:id])
    @user_grade=current_grade current_user.id
    respond_to do |format|
      if @job.update_job(job_params) 
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
  
  def receive_task
    Job.receive_task(params)
    @user_grade=current_grade current_user.id
    Pusher['taskboard_channel'].trigger('my_event',{:greeting => current_user.user_name + 'さんがタスクを引き受けてくれました'})
    redirect_to :action=>'index', :controller=>'top'
  end
  
  def finish_list
    @user_grade=current_grade current_user.id
    @tasks=Job.where('user_id=?',current_user.id).finish.latest.paginate(page: params[:page], per_page: 20) 
  end
  
  def pending_list
    @user_grade=current_grade current_user.id
    @tasks=Job.where('user_id=?',current_user.id).pending.latest.paginate(page: params[:page], per_page: 20) 
  end

  def group_job_list
    results=current_user.my_group_job_list(params[:group_id], 8)
    @todo_jobs=results[0]
    @doing_jobs=results[1]
    @done_jobs=results[2]
    @user_grade=current_grade current_user.id
    @group=my_group_map current_user.id
  end

  private
  def job_params
    params.require(:job).permit(:title,:description,:priority,:group_id,:status,:public_flag)
  end

  def my_group_map(user_id)
    @user_grade=current_grade user_id
    @groups=current_user.my_groups
    @groups
  end

  def job_complete(user_id)
    UserGrade.set_grade user_id
#    @grade_map=UserGrade.set_grade user_id
#    if @grade_map[:status] =='up'  
#      Pusher['taskboard_channel'].trigger('my_event',{:message => current_user.user_name + 'さんのレベルがアップしました。次のレベルまでに' + @grade_map[:next_count].to_s + "個必要です"})
#    else
#      Pusher['taskboard_channel'].trigger('my_event',{:message => '次のレベルまでに' + @grade_map[:next_count].to_s + "個必要です"})
#    end
  end
end
