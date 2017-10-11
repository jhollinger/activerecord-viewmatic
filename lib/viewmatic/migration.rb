module Viewmatic
  #
  # Helpers for creating and dropping views in ActiveRecord migrations.
  #
  module Migration
    #
    # Create the view named in "name". It must be defined in the view definitions file.
    #
    # @param [Symbol] name
    #
    def create_view(name)
      execute SchemaStatements.create_view Viewmatic.view name
    end

    #
    # Drop the view named in "name". It must be defined in the view definitions file.
    #
    # @param [Symbol] name
    #
    def drop_view(name)
      execute SchemaStatements.drop_view Viewmatic.view name
    end
  end
end
