#coding: utf-8

class BlogTemplate::Resolver < ActionView::Resolver
  include Singleton
  protected

  def find_templates(name, prefix, partial, details)
    conditions = {
      :path  => normalize_path(name,prefix),
      :locale => normalize_array(details[:locale]).first,
      :format => normalize_array(details[:formats]).first,
      :handler => normalize_array(details[:handlers]),
      :partial => partial || false
 
    }
    BlogTemplate.where(conditions).map do |record|
      initialize_template(record)
    end
  end

  def normalize_path(name, prefix)
    prefix.present? ? "#{prefix}/#{name}" : name
  end

  def normalize_array(array)
    array.map(&:to_s)
  end

  def initialize_template(record)
    source = record.body
    identifier = "BlogTemplate - #{record.id} - #{record.path.inspect}"
    handler = ActionView::Template.registered_template_handler(record.handler)

    details = {
      :format => Mime[record.format],
      :updated_at => record.updated_at,
      :virtual_path => virtual_path(record.path, record.partial)
    }
    ActionView::Template.new(source,identifier,handler,details)
  end
  
  def virtual_path(path, partial)
    return path unless partial
    if index = path.rindex("/")
      path.insert(index + 1, "_")

    else
      "_#{path}"
    end
  end

end

