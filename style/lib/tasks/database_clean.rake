namespace :style do
desc "Removes entries from database"
task :clean => :environment do
model_array = []
model_array.each {|model| model.destroy_all}
end
end
