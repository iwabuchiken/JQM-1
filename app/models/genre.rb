class Genre < ActiveRecord::Base

    #####################################
    #
    # Relations
    #
    #####################################
    has_many :categories

end
