class XHTMLBuilder

	attr_accessor :content

# Die Lösung geht generell davon aus dass niemand illegale Methoden in den jeweiligen Tags aufruft.
# Wie eine Fehlerbehandlung auszusehen hat die nur die im jeweiligen Tag erlaubten Methodenaufrufe
# zulässt ist nicht klar, denn hier müsste man den Inhalt der übergebenen Blöcke prüfen.

# Aus dem selben Grund funktioniert in dieser Lösung das Tag <p> nicht richtig.

   def initialize
      
      @content = ''
   
   end
   
   def html
      @content = "<html>\n"
      yield
      @content = @content + "</html>\n" # \n eigentlich unnötig aber von spec verlangt 
   end

   def head (&tag)
      @content = @content + "<head>\n"
      yield
      @content = @content + "</head>\n"
   end 
   
   def title (text)
      @content = @content + "<title>\n" + text + "\n</title>\n"
   end 

   def body
      @content = @content + "<body>\n"
      yield      
      @content = @content + "</body>\n"
   end 
   
   #alternativ lösung anstelle von 6 methoden für jedes h-tag. Nicht kompatibel mit example.rb!
   def headline(size, text)
      @pSize
      if size > 6 then 
         @pSize = 6
      elsif size < 1 then 
         @pSize = 1
      else 
         @pSize = size
      end
      @content = @content + "<H" + size.to_s + ">" + text + "</H" + size.to_s + ">\n"
   end

   # Bessere Lösung als *text?
   def p(*text)
      if text[0] != nil
         @content = @content + "<p>\n" + text[0] + "\n</p>\n"
      elsif block_given?
      # benötigt eine weitere abfrage die prüfen kann ob der Block text oder code enthält.
      # Lösung durch Metaprogrammierung möglich? Wenn ja dann unklar wie diese durchzuführen wäre.
         @content = @content + "<p>\n"
         yield
         #@content = @content + yield 
         @content = @content + "\n</p>\n"         
      end
   end   

   def b(text)
      @content = @content + "<b>\n" + text + "\n</b>\n"
   end

   def i(text)
      @content = @content + "<i>\n" + text + "\n</i>\n"
   end

   def div (&tag)
      @content = @content + "<div>\n"
      yield
      @content = @content + "</div>\n"
   end 
   
   def ul (&tag)
      @content = @content + "<div>\n"
      yield
      @content = @content + "</div>\n"
   end 

   def li(text)
      @content = @content + "<li>" + text + "</li>\n"
   end
   
   def method_missing
      @content = @content + "<p> Hier wurde versucht eine unbekannte Methode aufzurufen! </p>\n"
   end

end
