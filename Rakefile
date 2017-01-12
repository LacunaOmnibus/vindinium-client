require 'rdoc/task'
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/testhelper.rb', 'test/test_*.rb']
  t.verbose = true
end

RDoc::Task.new do |rdoc|
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include('README.md', 'lib/**/*.rb')
end
