#coding: utf-8

module User::Finder
         extend ActiveSupport::Concern
  included do
    has_many :jobs
    has_one :blog

    #JOB関連
    def my_job_list(per_count)
      begin
        @todo_jobs  = self.jobs.todo.latest.limit(per_count)
        @doing_jobs = self.jobs.doing.latest.limit(per_count)
        @done_jobs  = self.jobs.done.latest.limit(per_count)
        [@todo_jobs, @doing_jobs, @done_jobs]
      rescue ActiveRecord::RecordNotFound
        logger.error("My job data not found.")
        []
      rescue RuntimeError => e
        logger.error("application error!:"+e.message)
        []
      end
    end

    #Group関連のJob一覧 
    def my_group_job_list(group_id, per_count)
      begin
        @todo_jobs   = self.jobs.todo.where('group_id=?',group_id).latest.limit(per_count)
        @doing_jobs  = self.jobs.doing.where('group_id=?',group_id).latest.limit(per_count)
        @done_jobs   = self.jobs.done.where('group_id=?',group_id).latest.limit(per_count)
        [@todo_jobs, @doing_jobs, @done_jobs]
      rescue ActiveRecord::RecordNotFound 
        logger.error("My group job data not found.")
        []
      rescue RuntimeError => e
        logger.error("application error!:"+e.message)
        []
      end
    end

    #my_blog情報の取得
    def my_blog
      begin
        @my_blog = self.blog
      rescue ActiveRecord::RecordNotFound => fe
        logger.error("my blog not found!:"+ fe.message)
        []
      rescue RuntimeError => e
        logger.error("appplication error!:"+ e.message)
        []
      end
    end

    #Jobレポート用のメソッド
    def job_report
      begin
        @todo_jobs  = self.jobs.todo
        @doing_jobs = self.jobs.doing
        @done_jobs  = self.jobs.done
        @pending_jobs = self.jobs.pending
        @finish_jobs  = self.jobs.finish
        {todo: @todo_jobs, doing: @doing_jobs, done: @done_jobs, pending: @pending_jobs, finish: @finish_jobs}
      rescue ActiveRecord::RecordNotFound => are
        logger.error "recort not fount:"  + are.message
      rescue RuntimeError => e
        logger.error "Application error:" + e.message
      end
    end

  end
end 
