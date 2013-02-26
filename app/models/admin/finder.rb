module Admin::Finder
  def my_job_list
       begin
        @todo_jobs  = Job.todo.latest.limit(per_count)
        @doing_jobs = Job.doing.latest.limit(per_count)
        @done_jobs  = Job.done.latest.limit(per_count)
        [@todo_jobs, @doing_jobs, @done_jobs]
      rescue => e
        p e
        raise JobError ,"job一覧を取得しようとして失敗しました。"
      end
  end
end
