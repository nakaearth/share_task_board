#coding: utf-8

module TasksHelper
  def status_str(value)
    if value == 1
      "TODO"
    elsif value == 2
      "Doing"
    elsif value == 3
      "Done"
    elsif value == 0
      "peding"
    else
      ""
    end
  end
  
  def priority_str(value)
    if value == 0
      "普通" 
    elsif value == 1
      "やや優先"
    elsif value == 2
      "最優先"
    else
      ""
    end
  end
  
end
