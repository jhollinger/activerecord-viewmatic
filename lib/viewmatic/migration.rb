module Viewmatic
  #
  # Helpers for creating and dropping views in ActiveRecord migrations.
  #
  module Migration
    #
    # Create the view named in "name". It must be defined in the view definitions file.
    #
    # @param name [Symbol]
    #
    def create_view(name)
      view = Viewmatic.view name
      execute SchemaStatements.create_view view
    end

    #
    # Drop the view named in "name". It must be defined in the view definitions file.
    #
    # @param name [Symbol]
    # @param materialized [Boolean] true if you're dropping a materialized view
    #
    def drop_view(name, materialized: false)
      view = View.new name, materialized: materialized
      execute SchemaStatements.drop_view view
    end
  end
end
