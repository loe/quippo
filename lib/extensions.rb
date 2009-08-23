class String
  def br2nl
    gsub(/<br\s*\/*>/, "\n")
  end
  
  def nl2br
    gsub("\n", "<br>")
  end
end