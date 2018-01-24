module ApplicationHelper
  def fix_url(str)
    str.start_with?("http://") ? str: "http://#{str}"
  end

  # render "mm/dd/yyyy, HH:MM AM"
  def format_date(str)
    str.strftime("%m/%d/%Y, %I:%M %p")
  end
end
