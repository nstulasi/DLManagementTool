class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :designations, :dependent =>:destroy
  
  accepts_nested_attributes_for :user, :allow_destroy => true
  accepts_nested_attributes_for :project, :allow_destroy => true
  
  accepts_nested_attributes_for :designations, :allow_destroy=>true
  
  attr_accessible :user_id, :project_id, :level, :memberships_attributes, :designations_attributes
  
  has_many :assignments
  has_many :tasks, :through => :assignments
  accepts_nested_attributes_for :assignments, :tasks
  attr_accessible :assignments, :assignments_attributes
  
  def admin?
    self.level==0?true:false
  end
  
  def current?
    self.project_id=current_project.id
    self.user_id=current_user.id
  end
end
