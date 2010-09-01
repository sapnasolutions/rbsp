require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('sapna_best_practices', '0.1.0') do |x|
  x.description               = "rails best practices expanded with a whole bunch of web security"
  x.url                       = "https://github.com/sapnasolutions/rbsp"
  x.author                    = "Sapna Solutions"
  x.email                     = "rien@sapnasolutions.com"
  x.runtime_dependencies      = ["rails_best_practices >=0.4.0"]
  x.ignore_pattern            = []
  x.development_dependencies  = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each{|x| load x}