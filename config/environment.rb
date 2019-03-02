require 'bundler/setup'
Bundler.require

require 'rake'
require 'active_record'
require 'yaml/store'
require 'ostruct'
require 'date'

DBNAME = "halloween"

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), "../lib/support", "*.rb")].each {|f| require f}

DBRegistry[ENV["ACTIVE_RECORD_ENV"]].connect!
DB = ActiveRecord::Base.connection

if ENV["ACTIVE_RECORD_ENV"] == "test"
  ActiveRecord::Migration.verbose = false
end


sql = <<-SQL
  CREATE TABLE IF NOT EXISTS costumes (
    id INTEGER PRIMARY KEY,
    name TEXT,
    price INTEGER,
    size INTEGER,
    image_url TEXT,
    created_at DATETIME,
    updated_at DATETIME
  )

  SQL

ActiveRecord::Base.connection.execute(sql)

sql = <<-SQL
  CREATE TABLE IF NOT EXISTS costume_stores (
    id INTEGER PRIMARY KEY,
    name TEXT,
    location TEXT,
    costume_inventory INTEGER,
    num_of_employees INTEGER,
    still_in_business BOOLEAN,
    closing_time DATETIME,
    opening_time DATETIME
  )
  SQL

ActiveRecord::Base.connection.execute(sql)

sql = <<-SQL
  CREATE TABLE IF NOT EXISTS haunted_houses (
    id INTEGER PRIMARY KEY,
    name TEXT,
    location TEXT,
    theme TEXT,
    price INTEGER,
    family_friendly BOOLEAN,
    opening_date DATETIME,
    closing_date DATETIME,
    description STRING
  )
  SQL
ActiveRecord::Base.connection.execute(sql)
