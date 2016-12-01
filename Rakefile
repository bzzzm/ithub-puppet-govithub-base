require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'
require 'colorize'
require 'ra10ke'

# Chain tasks
namespace :govithub do

    # Puppet Lint
    PuppetLint::RakeTask.new :lint do |config|

        # pattern
        config.pattern = "**/*.pp"

        # disable some checks
        config.disable_checks = ['single_quote_string_with_variables', 'trailing_whitespace', 'hard_tabs', '2sp_soft_tabs', 'autoloader_layout']

        # only errors
        config.error_level = :error
    end

    desc "Install puppet modules using r10k"
    task :install do
        sh "env PUPPETFILE_DIR=./modules r10k -v INFO puppetfile install"
    end

    desc "Wrapping all validations into one task"
    task :validate do
        begin
            ['syntax:manifests', 'syntax:templates', 'syntax:hiera'].each do |t|
                puts "running task #{t.colorize(:yellow)}"
                Rake::Task[t].execute
            end
        end
    end
end