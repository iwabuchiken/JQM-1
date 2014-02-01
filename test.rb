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

    def v_4_1_3_7_zip_file
        
        require 'zip/zip'
        require 'zip/zipfilesystem'
        
        archive = "test.zip"
        
        # Zip::ZipFile.open(archive, Zip::CREATE) do |zipfile|
        Zip::ZipFile.open(archive, 'w') do |zipfile|
            
              zipfile.add("zip","test.rb")  # => param1: file name to be created in the zip fle
                                            # => param2: The taget file name to be zipped
              # zipfile.add("test.rb","zip")  # => No such file or directory - zip
              # zipfile.add(".",File.basename(__FILE__))
            
        end
        
        
        puts "DONE"
        
    end

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
        
        
        while (i < (len - 1)) do
            
            t1      = Moji.type(cur_char)
            t2      = Moji.type(next_char)
            
            # J1
            if t1 == t2
                
                token += next_char
                
                # J2
                cur_char = next_char
                i += 1
                next_char = text[i+1]
                
            else#if t1 == t2
                
                if t1 == "ZEN_KANJI"
                    
                    a_kanji.push(token)
                    
                    cur_char = next_char
                    next_char = text[i+1]
                    
                else
                    
                    a_kanji.push(token)
                    
                end
                
            end#if t1 == t2
            
        end#while (i < (len - 1)) do
      
        return "abcdef"

    end#cur_morph(text)
    
end

class Test
    include V_1_8_1_1
    
end


# do_2
# Test.new.do_3
t = Test.new

t.cut_morph("abc")

# t.v_4_1_3_7_zip_file
