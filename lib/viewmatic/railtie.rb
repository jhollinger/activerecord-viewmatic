module Viewmatic
  class Railtie < Rails::Railtie
    railtie_name :viewmatic

    rake_tasks do
      load 'tasks/viewmatic.rake'
    end
  end
end
