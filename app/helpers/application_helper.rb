module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end
  
  def identify_user(user)
    if user.nil?
      "the public"
    elsif user == current_user
      "your"
    else
      link_to "#{user.twitter_screen_name}'s", "http://twitter.com/#{user.twitter_screen_name}"
    end
  end
  
  def class_if(condition, *class_names)
    "class=\"#{class_names.join(' ')}\"" if condition
  end
  
  # Thanks go to mojombo for this one...
  def clippy(text, bgcolor='#FFFFFF')
    html = <<-EOF
      <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
              width="110"
              height="14"
              id="clippy" >
      <param name="movie" value="/flash/clippy.swf"/>
      <param name="allowScriptAccess" value="always" />
      <param name="quality" value="high" />
      <param name="scale" value="noscale" />
      <param NAME="FlashVars" value="text=#{text}">
      <param name="bgcolor" value="#{bgcolor}">
      <embed src="/flash/clippy.swf"
             width="110"
             height="14"
             name="clippy"
             quality="high"
             allowScriptAccess="always"
             type="application/x-shockwave-flash"
             pluginspage="http://www.macromedia.com/go/getflashplayer"
             FlashVars="text=#{text}"
             bgcolor="#{bgcolor}"
      />
      </object>
    EOF
  end
  
  def quip_citation(quip)
    if quip.attribution.blank?
      out = <<-EOF
        <cite>#{link_to(quip.user.display_name, user_quips_url(quip.user))}</cite>
      EOF
    else
      out = <<-EOF
        <cite>#{quip.attribution}</cite> <span class="author">via #{link_to(quip.user.display_name, user_quips_url(quip.user))}</span>
      EOF
    end
  end
  
=begin
  <cite><%= link_to((q.user.twitter_name.nil? ? q.user.twitter_screen_name : q.user.twitter_name), "http://twitter.com/#{q.user.twitter_screen_name}") %></cite>
  <em><%= link_to("#{time_ago_in_words(q.created_at)} ago", "http://twitter.com/#{q.user.twitter_screen_name}/status/#{q.twitter_id}") %></em>
=end
end
