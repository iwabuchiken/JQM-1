module Const
    
    #==============================
    #
    # => NR4
    #
    #==============================
    BACKUP_PATH = "doc/backup"
    
    BACKUP_URL_NR4_KEYWORDS     =
        "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add"
    
    BACKUP_URL_NR4_CATEGORIES   =
        "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/categories/add"
    
    BACKUP_FNAME_CSV   =
        "nr4_csv.zip"
    
    MODELS_PATH = "app/models"
    
    LOG_PATH    = "doc/mylog"
    
    LOG_PATH_ARTICLES    = "doc/mylog/articles"
    
    LOG_FILE_NAME = "log.log"
    
    #REF module in module //http://stackoverflow.com/questions/4255596/rails-3-including-nested-module-inside-controller answered Nov 23 '10 at 11:58
    module SL
    
        LOG_PATH_SL    = "doc/mylog/sl"
    
        LOG_FILE_NAME = "log.log"
      
        PASSWD_SL_Key   = "passwd_sl"
        
        PASSWD_SL_NewItem   = "sl_NewItem"
        
        PASSWD_SL_PurHist   = "sl_PurHist"
        
    end
    
    module LM
    
        LOG_PATH_LM    = "doc/mylog/lm"
    
        LOG_FILE_NAME = "log.log"
      
        PASSWD_LM_Key   = "passwd_lm"
        
        PASSWD_LM_NewItem   = "lm_NewItem"
        
    end
    
    module Admin
        
        HerokuLocal = {
            "sl/items" =>
                {"heroku_url" =>
                    "items",
                    # "http://cosmos-jqm-1.herokuapp.com/items?class=link",
                 "local_url" =>
                    "items"},
                    # "http://localhost:3001/items?class=link"},
            "nr4/articles" =>
                {"heroku_url" =>
                    "nr4/articles",
                    # "http://cosmos-jqm-1.herokuapp.com/nr4/articles?class=link",
                 "local_url" =>
                    "nr4/articles"},
                    # "http://localhost:3001/articles?class=link"},
                    
            "natulang/natulangs" =>
                {"heroku_url" =>
                    "natulangs",
                    # "http://cosmos-jqm-1.herokuapp.com/nr4/articles?class=link",
                 "local_url" =>
                    "natulangs"},
                    # "http://localhost:3001/articles?class=link"},
                    
            "location/locations" =>
                {"heroku_url" =>
                    "locations",
                    # "http://cosmos-jqm-1.herokuapp.com/nr4/articles?class=link",
                 "local_url" =>
                    "locations"},
                    # "http://localhost:3001/articles?class=link"},
        }
        
    end



end

#doc/backup/nr4