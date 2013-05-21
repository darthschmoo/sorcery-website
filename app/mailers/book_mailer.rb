class BookMailer < GMailer
  def send_signed_copy( book, book_files, ebook_signature, opts = {} )
    @book = book
    @ebook_signature = ebook_signature
    
    for file in book_files
      attachments["#{file.basename}"] = File.read( file )
    end
    
    mail( to:      "#{ebook_signature.name} <#{ebook_signature.email}>",
          from:    "#{book.author.name} <keeputahweird@gmail.com>",
          subject: "Attached: Your signed copy of #{book.title}"
    )
  end
  
  def test_connection
    mail( to: "bryce_anderson@yahoo.com",
          from: "keeputahweird@gmail.com",
          subject: "Testing Sorcery Mailer",
          body: "Many good days go by."
    )
  end
end
