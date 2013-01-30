#coding: utf-8

module Job::Finder
  extend ActiveSupport::Concern
  included do
    scope :latest,-> {order('updated_at desc') }
    scope :todo, ->{where('status=?',1) }
    scope :doing,-> {where('status=?',2) }
    scope :done, -> {where('status=?',3) }
    scope :finish,-> {where('status=?',4) }
    scope :pending,-> {where('status=?',0)}
 
    belongs_to :user
    belongs_to :group

    def self.job_list(per_count)
      begin
        @todo_jobs  = self.todo.latest.limit(per_count)
        @doing_jobs = self.doing.latest.limit(per_count)
        @done_jobs  = self.done.latest.limit(per_count)
        [@todo_jobs, @doing_jobs, @done_jobs]
      rescue => e
        p e
        raise JobError ,"job一覧を取得しようとして失敗しました。"
      end
    end
    def self.receive_job_list(user_id, per_count)
      begin
        @todo_tasks  = self.todo.where('r_user_id=?',user_id).latest.limit(per_count)
        @doing_tasks = self.doing.where('r_user_id=?',user_id).latest.limit(per_count)
        @done_tasks  = self.done.where('r_user_id=?',user_id).latest.limit(per_count)
        [@todo_tasks, @doing_tasks, @done_tasks]
      rescue
        raise JobError ,"受託したJob一覧を取得しようとして失敗しました。"
      end
    end
 
   #所属しているグループの全タスク
    def self.group_all_jobs(group_id, per_count)
      begin
        @todo_tasks  = self.todo.where('group_id=?',group_id).latest.limit(per_count)
        @doing_tasks = self.doing.where('group_id=?',group_id).latest.limit(per_count)
        @done_tasks  = self.done.where('group_id=?',group_id).latest.limit(per_count)
        [@todo_tasks, @doing_tasks, @done_tasks]
      rescue
        raise JobError ,"Group Job一覧を取得しようとして失敗しました。"
      end
    end
  end 

  #Instance method
  # def hoge
  #   hoge action.
  # end
end
