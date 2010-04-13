# To change this template, choose Tools | Templates
# and open the template in the editor.
require 'fileutils'
require 'rails_best_practices'
require 'yaml'

class RbpCommons
  def self.run_id
    "1"
  end
  
  def self.run
    rbp_run_hash = {}
    rbp_run_hash[run_id] = []

    runner = RailsBestPractices::Core::Runner.new
    files = expand_dirs_to_files(["."])
    files = model_first_sort(files)
    files = add_duplicate_migrations(files)
    ['vendor', 'spec', 'test', 'stories'].each do |pattern|
      files = ignore_files(files, "#{pattern}/")
    end
    files.each { |file| runner.check_file(file) }

    runner.errors.each {|error| rbp_run_hash[run_id] << error.to_s}
    #serialize(rbp_run_hash)
    return rbp_run_hash
  end

  def self.expand_dirs_to_files *dirs
    extensions = ['rb', 'erb', 'haml', 'builder']

    dirs.flatten.map { |p|
      if File.directory? p
        Dir[File.join(p, '**', "*.{#{extensions.join(',')}}")]
      else
        p
      end
    }.flatten
  end

  # for law_of_demeter_check
  def self.model_first_sort files
    files.sort { |a, b|
      if a =~ /models\/.*rb/
        -1
      elsif b =~ /models\/.*rb/
        1
      else
        a <=> b
      end
    }
  end

  # for always_add_db_index_check
  def self.add_duplicate_migrations files
    migration_files = files.select { |file| file.index("db/migrate") }
    (files << migration_files).flatten
  end

  def self.ignore_files files, pattern
    files.reject { |file| file.index(pattern) }
  end


  ##
  def self.serialize(rbp_run_hash={})
    File.open("#{RAILS_ROOT}/tmp/rbp_ui/#{Time.now.strftime('%Y%m%d')}.yml", "w+") do |f|
        f.write rbp_run_hash.to_yaml
      end
  end
end
