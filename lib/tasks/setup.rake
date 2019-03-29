$: << File.expand_path('../../app', __dir__)
load File.join(__dir__, 'procsd.rake')

desc 'setup project'
task :setup do
  Rake::Task['procsd:create_yml'].invoke
end
