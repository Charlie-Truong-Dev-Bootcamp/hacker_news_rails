module ApplicationHelper
  def date_format(datetime)
    datetime.strftime("%m-%d-%Y %I:%M%P")
  end
end
