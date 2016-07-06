require 'active_record'
require 'digest'

class Note < ActiveRecord::Base
 # code, title, description, created_at, visible

  def proper_title(default)
    title && !title.empty? ? title : default
  end
end
