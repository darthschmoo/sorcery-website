require 'fileutils'

class BookSubmission < ActiveRecord::Base
  SUBMISSIONS_FOLDER = File.join( Rails.root, "shared", "submissions" )
  
  validates_presence_of(:file)
  
  def file=( file )
    if file.is_a?(String)
      return super( file )
    else
      raise "Submissions folder doesn't exist." unless File.exist?( SUBMISSIONS_FOLDER )

      name = file.original_filename.filenameize
      dest = File.join( SUBMISSIONS_FOLDER, name )

      FileUtils.mv( file.tempfile.to_path, dest ) 
      
      super name
    end
  end
  
  def mimetype
    case self.filetype
    when "pdf"
      "application/pdf"
    when "doc"
      "application/msword"
    when "docx"
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    when "txt"
      "text/plain"
    when "mobi"
      "application/x-mobipocket-ebook"
    when "epub"
      "application/epub+zip"
    when "rtf"
      "application/rtf"
    else
      "application/octet-stream"
    end
  end
  
  def filetype
    file.split(".").last
  end
end
