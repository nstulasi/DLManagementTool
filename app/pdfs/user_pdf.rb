class UserPdf < Prawn::Document
  def initialize(users, view)
    super(top_margin: 70)
    @users = users
    @view = view
    title
    line_items
  end
  
  def title
    text "User List", size: 30, style: :bold
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
    [["User Name","Email", "Number"]] +
    @users.map do |item|
      [item.name, item.email, item.number]
    end
  end
  
end