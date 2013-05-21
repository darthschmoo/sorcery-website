# Tries to behave as ActionMailer does, but delivers emails
# through 

class GMailer < ActionMailer::Base
  def __example
    gmail.deliver do
      to "bryce_anderson@yahoo.com"
      subject "Having fun reading my book!!"
      text_part do
        body "Text of plaintext message."
      end
      add_file "/Users/andersbr/Documents/writ/fic/improbable/final/improbable_rise.final.epub"
    end
  end
  
  
  # options:
  #   :send_email        => "sending_email@gmail.com"
  #   :password          => "P4sSw0rd2gMa!l*aCC0unt"
  #   :recipient_email   => "whoever_imma_send@it.to"
  #   :subject           => "Custom email subject"
  #   :recipient_name    => "Chet"
  def send_the_book( book, email, opts )
    raise "Not using this"
    Gmail.new( opts[:send_email], opts[:password] ).deliver do
      default_body = <<-EOF
To whom it may concern.

You have a book now.      
      EOF
      to email
      subject opts[:subject] || "Your book, sir."

      text_part do
        body 
      end

      for file in book.formats
        add_file file
      end
    end  
  end
end