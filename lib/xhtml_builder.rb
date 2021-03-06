class XHTMLBuilder

   attr_accessor :content

   def initialize
      @content = ""
   end

   def method_missing(method, *args, &block)
       @p_method = method.to_s
       @p_args_zero = *args
       #@p_block = block
       build(@p_method, @p_args_zero, &block)
   end

   def build(tag, *args, &block)   
      @content += "<" + tag + ">\n" 
      
      if args != nil then 
         @content += args[0].to_s + "\n"
      else
         puts "ERROR!"
      end
      if block_given? then 
         yield
      else
         puts "kein Block"
      end
      @content += "</" + tag + ">\n"
   end
end
