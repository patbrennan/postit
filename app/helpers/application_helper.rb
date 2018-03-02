module ApplicationHelper
  def fix_url(str)
    str.start_with?("http://") ? str: "http://#{str}"
  end

  # render "mm/dd/yyyy, HH:MM AM"
  def format_date(str)
    if logged_in? && !current_user.time_zone.blank? # tests nil or empty
      str = str.in_time_zone(current_user.time_zone)
    end
    
    str.strftime("%m/%d/%Y, %I:%M %p %Z")
  end
  
  def ajax_flash(div_id)
    response = ""
    flash_div = ""

    flash.each do |name, msg|
      if msg.is_a?(String)
        flash_div = "<div class=\"alert alert-#{name == :notice ? 'success' : 'error'} ajax_flash\"><a class=\"close\" data-dismiss=\"alert\">&#215;</a> <div id=\"flash_#{name == :notice ? 'notice' : 'error'}\">#{h(msg)}</div> </div>"
      end 
    end
    
    response = "$('.ajax_flash').remove();$('#{div_id}').prepend('#{flash_div}');"
    response.html_safe
  end
end
