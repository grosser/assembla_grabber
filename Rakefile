require 'init.rb'

desc 'Default: run spec.'
task :default => :spec

desc "Run all specs in spec directory"
task :spec do |t|
  options = "--colour --format progress --loadby --reverse"
  files = FileList['spec/**/*_spec.rb']
  system("spec #{options} #{files}")
end

desc "Initialize database"
task :init do
  `ruby db/init.rb`
end

desc "grab a single page"
task :grab do
  raise unless ENV['PAGE']
  puts AssemblaGrabber.new('config.yml').grab_page(ENV['PAGE'])
end

desc "grab and store all pages from root"
task :grab_all do
  AssemblaGrabber.new('config.yml').grab_all
end