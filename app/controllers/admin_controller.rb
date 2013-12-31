class AdminController < ApplicationController
  def main
      
      @applist = _main_get_applist
      
  end

  def m_main
  end

  def sub1
  end

  def sub2
  end
end

class AppInfo
    
    attr_accessor :name, :cont, :action
    
    @name
    
    @cont
    
    @action
    
    # @cont
#     
    # @action
    
end

private

def _main_get_applist
    
    applist = []
    
    names   = [
            "TwitterApp",   "NR4",
            "AiKodaka",     "ShoppingList"]
    
    conts   = [
            "twitter_app",          "nr4/articles",
            "ai_kodaka/ai_kodakas", "sl/items"]
    
    actions = [
            "main",     "index",
            "index",    "index"]
    
    names.size.times do |i|
        
        list = AppInfo.new
      
        list.name   = names[i]
        list.cont   = conts[i]
        list.action = actions[i]
        
        applist.push(list)
      
    end
    
    return applist
    
end