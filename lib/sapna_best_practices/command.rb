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

runners = [
  SapnaBestPractices::Core::Runners::Runner.new(:single),
  SapnaBestPractices::Core::Runners::GroupedRunner.new(:grouped),
  SapnaBestPractices::Core::Runners::FileParseRunner.new(:file_parse)
]

runners.each { |runner| 
  runner.set_debug if options['debug'] 
  runner.run(files)
}

errors_size = infos_size = 0
runners.map { |runner| 
  errors_size += runner.errors.size 
  infos_size += runner.infos.size 
}
puts "\nFound #{errors_size} error messages" if errors_size > 0
puts "\nFound #{infos_size} information messages" if infos_size > 0

exit errors_size
