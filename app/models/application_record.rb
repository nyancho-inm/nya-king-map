class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def previous
    Cat.where("id < ?", self.id).order("id DESC").first
  end
  def next
    Cat.where("id > ?", self.id).order("id ASC").first
  end

end
