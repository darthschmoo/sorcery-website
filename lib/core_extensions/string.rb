# App extensions for the String class
class String
  def filenameize
    self.downcase.gsub(/[^a-z0-9.]/, '_').gsub(/_{2,}/, "_").gsub(/_*\._*/,".")
  end











  
    # Eliminates 1, I, 0, O, 8, B from the codes.
  HUMAN_DISTINGUISHABLE_CHARS = %w{ 2 3 4 6 7 9 A C D E F G H J K L M N P Q R T V W X Y Z }

  # Returns a random hexadecimal string of the given length.
  def self.random_hex_string( len )
    s = rand(16 ** len).to_s(16)
    s = ("0" * (len - s.length)) + s
  end

  def self.random_human_legible_code( len )
    # http://stackoverflow.com/questions/88311/how-best-to-generate-a-random-string-in-ruby
    # Eliminates 1, I, 0, O, 8, B from the codes.
    charset = HUMAN_DISTINGUISHABLE_CHARS
    (0...len).map{ charset.to_a[rand(charset.size)] }.join
  end

  def as_var_name
    self.downcase.gsub( /\W+/, "_").gsub(/_+/, "_").gsub(/[^a-z0-9_]/, '')
  end

  # def valid_email_address?
  #   ( self.strip.match(Email::VALIDATING_REGEX) ) ? true : false
  # end

  # Splits along whitespace only.
  # Will exceed requested line length when an unbroken word
  # is longer than the requested count.  Preserves original line 
  # endings, but otherwise doesn't preserve whitespace.  It sucks, is what I'm saying.
  def split_into_lines_no_longer_than( count )
    lines = []

    for source_line in self.lines
      lines << ""
      # puts "<#{source_line.split(/\s+/).join('> <')}>"
      for word in source_line.split(/\s+/)
        if lines.last.length + word.length > count
          lines << word
        elsif lines.last.blank?
          lines.last << word
        else
          lines.last << " #{word}"
        end
      end
    end

    lines
  end

  # for using strings as hash keys, to make them more likely to match  
  def canonize
    self.strip.gsub(/[.,]/, ' ').downcase.split(/\s+/).join(" ")
  end
  
  def shuffle!
    self.replace( self.chars.to_a.shuffle!.join('') )
  end
  
  def shuffle
    self.dup.shuffle!
  end
end