module Viewmatic
  #
  # Represents a view to be built.
  #
  class View
    #
    # Initialize a new view.
    #
    # @param name [Symbol] name of the view as it will appear in the database
    #
    def initialize(name)
      @name = name
      @materialized = false
    end

    # Get/set the view name
    def name(val = nil)
      @name = val unless val.nil?
      @name
    end

    # Get/set the query backing the view
    def query(val = nil)
      @query = val unless val.nil?
      @query
    end

    # Get/set the query column name overrides
    def column_names(val = nil)
      @column_names = val unless val.nil?
      @column_names
    end

    # Get/set the materialized status
    def materialized(val = nil)
      @materialized = val unless val.nil?
      @materialized
    end
  end
end
