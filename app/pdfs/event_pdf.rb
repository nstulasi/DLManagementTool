class EventPdf < Prawn::Document
  def initialize(events, view)
    super(top_margin: 70)
    @events = events
    @view = view
    title
    line_items
  end
  
  def title
    text "Event List", size: 30, style: :bold
  end
  
  def line_items
    move_down 20
    table line_item_rows do
      row(0).font_style = :bold
      column(0).width= 145
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Event name","Start date", "End date"]] +
    @events.all.map do |item|
      [item.name, to_date(item.start_at), to_date(item.end_at)]
    end
  end

   def to_date(date)
     if !date.nil?
     date.strftime("%F")
     end
   end
end