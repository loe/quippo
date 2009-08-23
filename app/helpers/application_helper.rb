module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
  
  def identify_user(user)
    if user == current_user
      "your"
    elsif user.nil?
      "the public"
    else
      "#{user.twitter_screen_name}'s"
    end
  end
  
  def class_if(condition, *class_names)
    "class=\"#{class_names.join(' ')}\"" if condition
  end
end
