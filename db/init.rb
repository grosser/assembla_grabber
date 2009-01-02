require 'rubygems'
require 'activerecord'
require 'db/db.rb'

#create model table
ActiveRecord::Schema.define(:version => 1) do
  drop_table :pages rescue nil
  create_table :pages do |t|
    t.string :name
    t.text :text
    t.string :human_name
    t.timestamps
  end
end