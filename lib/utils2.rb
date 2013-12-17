require 'fileutils'
require 'net/ftp'
require "net/http"
require "uri"

require_dependency 'const'
include Const

# @max_line_num = 3000

def get_time_label_now()
  
  return Time.now.strftime("%Y/%m/%d %H:%M:%S")
  # return Time.now.strftime("%Y%m%d_%H%M%S")
  
end#def get_time_label_now()

def get_time_label_now_2()
  
  return Time.now.strftime("%Y%m%d_%H%M%S")
  # return Time.now.strftime("%Y%m%d_%H%M%S")
  
end#def get_time_label_now()


def write_log(dpath, text, file, line)
    
    # max_line_num = 300
    # max_line_num = 20000
    max_line_num = 40000
    
    #-----------------------
    # => File exists?
    #-----------------------

    dname = dpath
    #dname = "doc/mylog"
    #dname = "doc/mylog/articles"
    # fname = "mylog/log.log"
    # f = File.new(dname)
    
    if !File.exists?(dname)
        # => REF mkdir http://ruby-doc.org/stdlib-1.9.3/libdoc/fileutils/rdoc/FileUtils.html
#        FileUtils.mkdir dname

        #REF http://stackoverflow.com/questions/3686032/how-to-create-directories-recursively-in-ruby answered Sep 10 '10 at 15:49
        FileUtils.mkpath dname
    end

    # => REF SEPARATOR: http://doc.ruby-lang.org/ja/1.9.3/class/File.html#C_-P-A-T-H_-S-E-P-A-R-A-T-O-R
    fname = [dname, "log.log"].join(File::SEPARATOR)
    
    if !File.exists?(fname)
        # => REF touch: http://stackoverflow.com/questions/8100574/creating-an-empty-file-in-ruby-touch-equivalent answered Nov 11 '11 at 22:14
        FileUtils.touch(fname)
    end    
    
    
    # f = open(fname, "r")
    f = open(fname, "a")
    # f = open("mylog/log.log", "a")
    # f = open("log.log", "a")
    
    #-----------------------
    # => File full?
    #-----------------------    
    # lines = f.readlines()
    
    # if lines.length > @max_line_num
    
    # if File.size?(fname) > @max_line_num
    # if File.size(fname) && File.size(fname) > @max_line_num
    if File.size(fname) && File.size(fname) > max_line_num
        # => REF rename http://stackoverflow.com/questions/5530479/how-to-rename-a-file-in-ruby answered Apr 3 '11 at 15:29
        # File.rename(f, 
                # dname + File::SEPARATOR +
                # File.basename(f, File.extname(f)) + "_" +
                # get_time_label_now_2 + File.extname(f))
        new_fname = [dname,
                    File.basename(f, File.extname(f)) + "_" +
                      get_time_label_now_2 + File.extname(f)].join(File::SEPARATOR)
        
        # => REF cp: http://miyohide.hatenablog.com/entry/20050916/1126881010
        # => REF cp: http://doc.ruby-lang.org/ja/search/module:FileUtils/query:FileUtils.%23cp/
        FileUtils.cp(fname, new_fname)
                    
                  # File.basename(f, File.extname(f)) + "_" +
                    # get_time_label_now_2 + File.extname(f))
        
        f.close
        
        # f = open(fname, "a")
        f = open(fname, "w")
    
    end
    
      
    
    f.write("[begin]------------------------=\n")
    
    # f.write("[#{get_time_label_now()}]" + line + ": " + text)
    f.write("[#{get_time_label_now()}] [#{file}: #{line}]\n")
    # f.write("\n#{text}")
    # f.write("\n")
    # f.write("\n\nyes")
    f.write(text)
    
    f.write("\n")
    # f.write("<br/>")
    
    if File.size(fname)
        f.write("File size=" + File.size(fname).to_s + "\n")
        # f.write("@max_line_num=" + @max_line_num.to_s)
    else 
      
        f.write("File.size(fname) => nil")
      
    end
    
    f.write("------------------------=[end]\n\n")
    
    f.close
  
end#def write_log()

=begin
    _post_data(remote_url, model)
    
    @param  model => Class
=end
def _post_data(remote_url, model)
    
    #debug
    write_log(
                  @log_path,
                  model.name,
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
    
    parameters = _backup_db__build_params(model)
    # return remote_url
    # return _get_backup_url
    
    #params = _backup_db__build_params(model)
  
  
    #debug
    write_log(
                  @log_path,
                  "Posting data... (url=#{remote_url})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

    x = Net::HTTP.post_form(
            URI.parse(URI.encode(remote_url)),
            parameters)
#    x = Net::HTTP.post_form(
#            URI.parse(remote_url),
#            parameters)
    

    #debug
    write_log(
                  @log_path,
                  "Posting data => Done: result=#{x.message}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
    return "Done (result => #{x})"
    
end#_post_data(remote_url, model)

def _post_data_2(remote_url, model)
    
    #debug
    model_name = model.class.to_s
    
    parameters = _backup_db__build_params_2(model)
    
    #debug
    write_log(
                  Const::LOG_PATH_ARTICLES,
                  "Posting data... (url=#{remote_url})",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)

    x = Net::HTTP.post_form(
            URI.parse(URI.encode(remote_url)),
            parameters)
#    x = Net::HTTP.post_form(
#            URI.parse(remote_url),
#            parameters)
    

    #debug
    write_log(
                  Const::LOG_PATH_ARTICLES,
                  "Posting data => Done: result=#{x.message}",
                  # __FILE__,
                  __FILE__.split("/")[-1],
                  __LINE__.to_s)
                  
    return "Done (result => #{x})"
    
end#_post_data_2(remote_url, model)

def _get_backup_url
    
    return "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add"
    
end

def _backup_db__build_params(kw)
    # Name
    params = {}
    
    attrs = [
                "name", "genre_id", "category_id",
                "remote_id", "created_at", "updated_at"]
    
    values = [
                kw.name, kw.genre_id, kw.category_id,
                kw.id, kw.created_at, kw.updated_at]
    
    attrs.size.times do |i|
        
        #REF add element http://www.rubylife.jp/ini/hash/index5.html
        params["data[Keyword][#{attrs[i]}]"] = values[i]
    
    end

    return params
    
end#_backup_db__build_params

def _backup_db__build_params_2(model)
    # Name
    params = {}
    
    model_name = model.class.to_s
    
    attrs = _get_attrs(model_name)
    
    values = _get_values(model)
    
    attrs.size.times do |i|
        
        #REF add element http://www.rubylife.jp/ini/hash/index5.html
        params["data[#{model_name}][#{attrs[i]}]"] = values[i]
    
    end

    return params
    
end#_backup_db__build_params_2(model)

def get_models()
    
    tmp = Dir.glob(File.join(Const::MODELS_PATH, "*.rb"))
    #tmp = Dir.glob("app/models/*.rb")
    
    models = []
        
    tmp.each do |x|
        
        model = File.basename(x, File.extname(x)).classify.constantize
        
        if model.class.to_s == "Class"
            #REF extension https://www.ruby-forum.com/topic/179524 2009-02-24 00:03
            models.push(File.basename(x, File.extname(x)).classify.constantize)
        end
        
    end#tmp.each do |x|
    
    return models
    
end#get_models()

def _download_file(fullpath)
    
    #REF http://qiita.com/akkun_choi/items/64080a8e17930879b4da
    
    stat = File::stat(fullpath)
    
    send_file(fullpath,
        :filename => File.basename(fullpath),
        :length => stat.size)
    
end#_download_file(fullpath)

def _get_attrs(model_name)
    
    attrs = []
    
    if model_name == "Category"
        
        attrs.push("name")
        attrs.push("genre_id")
        attrs.push("remote_id")
        
        attrs.push("created_at")
        attrs.push("updated_at")
        
    else
        
        return nil
        
    end
    
end

def _get_values(model)
    
    values = []
    
    # m = model_name.constantize
    
    if model.class.to_s == "Category"
    #if model == "Word"
        
        values.push(model.name)
        values.push(model.genre_id)
        values.push(model.id)
        
        values.push(model.created_at.to_s)
        values.push(model.updated_at.to_s)

    else
        
        return nil
        
    end
    
end#def _get_values(model_name)
