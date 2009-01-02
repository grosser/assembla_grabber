root = File.dirname(__FILE__)

ActiveRecord::Base.configurations = {"test" => {
  :adapter => "sqlite3",
  :database => File.join(root,'db.sqlite'),
}.with_indifferent_access}

ActiveRecord::Base.logger = Logger.new("#{root}/db.log")
ActiveRecord::Base.establish_connection(:test)