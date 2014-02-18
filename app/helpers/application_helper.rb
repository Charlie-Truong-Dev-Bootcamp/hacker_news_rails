module ApplicationHelper
  def date_format(datetime)
    datetime.strftime("%m-%d-%Y %I:%M%P")
  end

  def signed_in_user(id)
    User.find(id).username
  end
end
