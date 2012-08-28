require 'csv'

#lib/tasks/import.rake
desc "Imports a CSV file into an ActiveRecord table"
task :csv_model_import, :filename, :model, :needs => :environment do |task,args|

    lines = File.new(args[:filename]).readlines
    header = lines.shift.chomp.strip
    keys = header.split(',')

    binding.pry

    lines.each do |line|
        params = {}
        line = line.force_encoding "cp1252"
        values = CSV.parse_line(line)
        keys.each_with_index do |key,i|
            params[key] = values[i] == nil ? "" : values[i]
        end

   binding.pry

        Module.const_get(args[:model]).create(params)
    end
end



