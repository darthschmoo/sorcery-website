module StoriesHelper
  def friendly_word_count( story )
    wc = story.word_count
    
    case
    when wc > 1000000.0
      return sprintf("%0.1fM", wc / 1000000.0)
    when wc > 1000.0
      return sprintf("%0.1fK", wc / 1000.0)
    else
      return wc
    end
  end
end
