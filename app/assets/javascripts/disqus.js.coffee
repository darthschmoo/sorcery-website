disqus_inner_html = (id) -> 
  out = "<div id=\"disqus_thread\"></div>\n"
  out += "<script type=\"text/javascript\">\n"
  out += "var disqus_shortname = 'bannedsorcery';\n"
  out += "var disqus_identifier = '" + id + "';\n"
  out += "(function() {\n"
  out += "var dsq = document.createElement('script');\n"
  out += "dsq.type = 'text/javascript';\n"
  out += "dsq.async = true;\n"
  out += "dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';\n"
  out += "(document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);\n"
  out += "})(); \n"
  out += "</script> \n"
  out += "<noscript>Please enable JavaScript to view the <a href=\"http://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>\n"
  out += "<a href=\"http://disqus.com\" class=\"dsq-brlink\">comments powered by <span class=\"logo-disqus\">Disqus</span></a>"
  out
    
view_comments = (id) ->
  $('#comments').innerHTML = disqus_inner_html( id )
  
