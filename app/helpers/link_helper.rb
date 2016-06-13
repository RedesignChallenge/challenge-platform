module LinkHelper
  def video_embed(url)
    if url.include?('youtube.com') || url.include?('youtu.be')
      video_id = parse_youtube(url)
      embed_code = "<div class='embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item' style='max-width:100%' width='560' height='315' src='//www.youtube.com/embed/#{video_id}?rel=0&showinfo=0' frameborder='0' allowfullscreen></iframe></div>"
    elsif url.include?('vimeo.com')
      video_id = parse_vimeo(url)
      embed_code = "<div class='embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item' style='max-width:100%' width='560' height='315' src='//player.vimeo.com/video/#{video_id}?title=0&byline=0&portrait=0' frameborder='0' allowfullscreen></iframe></div>"
    end

    embed_code.html_safe
  end

  def parse_youtube(url)
    regex = /(?:.be\/|\/watch\?v=|\/(?=p\/))([\w\/\-]+)/
    url.match(regex)[1]
  end

  def parse_vimeo(url)
    regex = /\/\/(?:www\.)?vimeo.com\/([0-9a-z\-_]+)/i
    url.match(regex)[1]
  end
end
