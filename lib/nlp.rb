# module NLP
#   
  # MESSAGE = "nlp"
#   
  # def show_message
#       
      # return MESSAGE + " !! "
#       
  # end
#   
  # class NLPCLASS
#       
#       
#       
#       
  # end
#   
# end

class NLP
    # => REF class variable // http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
    class << self
        attr_accessor :message
        
        # => REF class method // http://stackoverflow.com/questions/5240911/class-methods-in-ruby-on-rails-3-im-totally-lost asked Mar 9 '11 at 3:18
        def get_message
            
            return "nlp --> YES"
            
        end
    end
    # attr_accessor :message
    
    @message = "nlp*****"
    # @message = "nlp???"
    # @@message = "nlp!!!"
    # @message = "nlp"
    # message = "nlp"
    
    def get_message
        
        return @@message
        # return @message
    end

=begin    
    def cut_morph(text)
        
        morphs = []
        
        if text == nil or text.length < 1
            
            return morphs
            
        end
        
        # Setup
        len = text.length
        a_kanji = []; a_hira = []
        
        i = 0
        cur_char    = text[i]
        next_char   = text[i+1]
        
        token       = cur_char
        
        t1      = Moji.type(cur_char)
        t2      = Moji.type(next_char)
        
        while (i < (len - 1)) do
            # J1
            if t1 == t2
                
                token += next_char
                
                # J2
                if i < (len - 1)
                    
                    cur_char = next_char
                    i += 1
                    next_char = text[i+1]
                    
                else
                    
                end
                
                
            else#if t1 == t2
                
            end#if t1 == t2
            
        end#while (i < (len - 1)) do
      
        return "abcdef"
      
    end
=end

end