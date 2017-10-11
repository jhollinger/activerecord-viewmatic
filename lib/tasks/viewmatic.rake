Dir.glob(Viewmatic::Schema.paths).each { |f| require f }

namespace :db do
  namespace :views do
    desc "Load all database views"
    task :load => :environment do
      Viewmatic.schemas.each(&:load!)
    end

    desc "Drop all database views"
    task :drop => :environment do
      Viewmatic.schemas.each(&:drop!)
    end
  end
end

Rake::Task['db:schema:load'].enhance do
  Rake::Task['db:views:load'].invoke
end

Rake::Task['db:test:prepare'].enhance do
  Rake::Task['db:views:load'].invoke
end
