class Phase < ActiveRecord::Base
  acts_as_nested_set
  belongs_to :project
  attr_accessible :name,:start,:end,:content,:project_id,:parent_id
  validates :name, :presence => true
  #validates :start, :presence => true
  #validates :end, :presence => true
  
  def self.get_csv(options = {})
    columns=["name","content","start","end"]
  CSV.generate(options) do |csv|
    csv << ["Phase name","Description","Start date","End date"]
    all.each do |phase|
      csv << phase.attributes.values_at(*columns)
      end
    end
  end

end
