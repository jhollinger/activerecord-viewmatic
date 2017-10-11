require 'active_record'

# Container module for all Viewmatic features.
module Viewmatic
  autoload :View, 'viewmatic/view'
  autoload :Model, 'viewmatic/model'
  autoload :Schema, 'viewmatic/schema'
  autoload :SchemaStatements, 'viewmatic/schema_statements'
  autoload :Migration, 'viewmatic/migration'
  autoload :VERSION, 'viewmatic/version'

  class << self
    # @return [Array<Viewmatic::Schema] all schemas loaded from file(s)
    attr_reader :schemas
  end
  @schemas = []

  #
  # Fetch the first view named "name" from all schemas. If it can't be found an exception is raised.
  #
  # @return [Viewmatic::View]
  #
  def self.view(name)
    schema = schemas.detect { |s| s.views.has_key? name }
    schema ? schema.views[name] : raise(ArgumentError, "Could not find view named `#{name}`")
  end
end

require 'viewmatic/railtie' if defined? Rails
