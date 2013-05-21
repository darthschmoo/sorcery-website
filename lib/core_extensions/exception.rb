class Exception
  def to_html_snippet
    snippet = "<pre>#{self.class.name}: #{self.message}\n"
    for line in self.backtrace
      snippet += "\t#{line}\n"
    end
    snippet += "</pre>"
    snippet.html_safe!
  end
end