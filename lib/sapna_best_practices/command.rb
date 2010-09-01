require 'optparse'


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: sapna_best_practices [options]"
  
  opts.on("-d", "--debug", "Debug mode") do
    options['debug'] = true
  end

  ['vendor', 'spec', 'test', 'stories'].each do |pattern|
    opts.on("--#{pattern}", "include #{pattern} files") do
      options[pattern] = true
    end
  end
  
  opts.on_tail('-v', '--version', 'Show this version') do
    puts File.read(File.dirname(__FILE__) + '/../../VERSION')
    exit
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end

  opts.parse!
end

files = RailsBestPractices::analyze_files(ARGV, options)

runner = SapnaBestPractices::Core::Runners::Runner.new(:single)
runner.set_debug if options['debug']
files.each { |file| runner.check_file(file) }

grouped_runner = SapnaBestPractices::Core::Runners::GroupedRunner.new(:grouped)
grouped_runner.set_debug if options['debug']
grouped_runner.check_files(files)

file_parse_runner = SapnaBestPractices::Core::Runners::FileParseRunner.new(:file_parse)
file_parse_runner.set_debug if options['debug']
# file_parse_runner.check_files(files)

runner.errors.each          { |error|  puts "ERROR: #{error}" }
grouped_runner.errors.each  { |error|  puts "ERROR: #{error}" }
runner.infos.each           { |info|    puts  "INFO: #{info}" }
#puts "\nPlease go to http://rails-bestpractices.com to see more useful Rails Best Practices."

puts "\nFound #{runner.errors.size + grouped_runner.errors.size} errors." if (runner.errors.size > 0) or (grouped_runner.errors.size > 0)
puts "Found #{runner.infos.size} information messages." if runner.infos.size > 0

exit runner.errors.size
