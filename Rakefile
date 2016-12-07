require 'rake/extensiontask'
require 'rspec/core/rake_task'
require 'fileutils'
require 'sys/cpu'

include Sys

XHYVE_TMP = 'tmp/xhyve'

# Compile native extensions task
Rake::ExtensionTask.new 'vmnet' do |ext|
  ext.lib_dir = 'lib/xhyve/vmnet'
end

# Spec test
RSpec::Core::RakeTask.new(:spec)

desc 'Build xhyve binary'
task :vendor do
  FileUtils.mkdir_p('tmp')
  Dir.chdir('tmp') do
    unless Dir.exist?('xhyve/.git')
      system('git clone https://github.com/mist64/xhyve.git') || fail('Could not clone xhyve')
    end
    Dir.chdir('xhyve') do
      system('git fetch') || fail('Could not fetch')
      system('git reset --hard origin/master') || fail('Could not reset head')
      system('make') || fail('Make failed')
    end
  end
  FileUtils.mkdir_p('lib/xhyve/vendor')
  FileUtils.cp('tmp/xhyve/build/xhyve', 'lib/xhyve/vendor')
end

desc 'Describe CPU'
task :cpu do
	puts "VERSION: " + CPU::VERSION
	puts "Load Average: " + CPU.load_avg.join(", ")
	puts "CPU Freq (speed): " + CPU.freq.to_s unless RUBY_PLATFORM.match('darwin')
	puts "Num CPU: " + CPU.num_cpu.to_s
	puts "Architecture: " + CPU.architecture
	puts "Machine: " + CPU.machine
	puts "Model: " + CPU.model
	system('sysctl -a | grep machdep.cpu.brand_string')
	system('sysctl -a | grep machdep.cpu.features')
	system('sysctl -a | grep machdep.cpu.extfeatures')
end

desc 'Build the ruby gem'
task :build do
  system('gem build xhyve-ruby.gemspec') || fail('Failed to build gem')
end

desc 'Install gem'
task install: :build do
  system('gem install xhyve-ruby*.gem') || fail('Couldn not install gem')
end

# Deps and defaults
task default: :spec
