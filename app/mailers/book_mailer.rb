class BookMailer < GMailer
  def send_signed_copy( book, book_file, recipient_email, recipient_name, message, opts = {} )
    
    attachments[book.title.filenameize + ".mobi"] = File.read( book_file )
    
    mail( to:      "#{recipient_name} <#{recipient_email}>",
          from:    "Bryce Anderson <keeputahweird@gmail.com>",
          subject: "Your signed copy of #{book.title}"
    )
  end
end