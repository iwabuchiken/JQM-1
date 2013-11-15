#coding:utf-8
module V_1_8_1_1
    

    def do_1
          
        a = "Russia supports Asad"
        puts a
        
        puts a.match(/A\w+/)
        
        b = "Russia supports アサド"
        
        puts b
        
        puts a.match(/A../)
        
        p b.match(/ア.../)
        
        puts "****"
        puts
        
        kw = "アサ"
        
        if (res = b.match(/#{kw}/))
          
        	puts "YES"
        	p "res=#{res}"
        	puts "res=#{res}"
        	 
        else
          
          puts "NO"
          p "res=#{res}"
           	
        end
    end
    
    def do_2
        
        a = "鳥インフルで男性死亡、3歳児重体 カンボジア"
        
        kw = "鳥...."
        
        if (res = a.match(/#{kw}/))
          
            puts "YES"
            p "res=#{res}"
            puts "res=#{res}"
            puts "a=#{a}"
             
        else
          
          puts "NO"
          p "res=#{res}"
            
        end
        
    end
    
    def do_3
        
        kw = "abc"
        
        a = "defabcdefxxx"
        
        puts "string is #{a}"
        puts "string is #{a.match(/#{kw}/)}"
        
    end
end

class Test
    include V_1_8_1_1
    
end


# do_2
Test.new.do_3