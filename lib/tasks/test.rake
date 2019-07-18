namespace :test do
  task rspec: :environment do
    Rake::Task['spec'].invoke
  end
end

Rake::Task["test"].clear.enhance ['test:rspec']
