class Designation < ActiveRecord::Base
  belongs_to :membership
    attr_accessible :membership_id, :role, :responsibility, :designations_attributes, :designation_attributes
  
  has_many :assignments
  has_many :tasks, :through => :assignments
  accepts_nested_attributes_for :assignments, :tasks
  attr_accessible :assignments, :assignments_attributes
end
