module Viewmatic
  #
  # Helpers for view-based ActiveRecord models.
  #
  module Model
    def self.included(model)
      model.extend ClassMethods
    end

    #
    # All view record are read-only.
    #
    # @return [Boolea] will always be true
    #
    def readonly?
      true
    end

    #
    # Class-level helper methods.
    #
    module ClassMethods
      #
      # Refresh the underlying materialized view.
      #
      def refresh!
        connection.execute "REFRESH MATERIALIZED VIEW #{table_name}"
      end
    end
  end
end
