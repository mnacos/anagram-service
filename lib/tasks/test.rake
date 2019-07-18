namespace :test do
  task rspec: :environment do
    Rake::Task['spec'].invoke
  end

  task performance: :environment do
    RSpec::Core::RakeTask.new(:performance) do |task, args|
      task.rspec_opts = '--tag performance'
    end
    Rake::Task['performance'].invoke
  end
end

Rake::Task["test"].clear.enhance ['test:rspec']
