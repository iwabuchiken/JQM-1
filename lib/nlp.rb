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
    
end