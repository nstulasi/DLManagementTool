class Event < ActiveRecord::Base
  has_event_calendar
  belongs_to :project 
  
    def self.get_csv(options = {})
    columns=["name","content","start_at","end_at"]
  CSV.generate(options) do |csv|
    csv << ["Event name", "Description","Start Date", "End date"]
    all.each do |event|
      csv << event.attributes.values_at(*columns)
    end
  end
end
end
