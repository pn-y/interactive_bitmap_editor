require 'rake/testtask'

task default: %w[run]

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :run do
  ruby 'bin/runner.rb'
end
