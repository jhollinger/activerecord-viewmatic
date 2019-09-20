module Viewmatic
  #
  # Represents a schema of views to be built.
  #
  class Schema
    class << self
      # @return [Array<String>] Array of globs matching view definition files. default: ['db/views.rb', 'db/views/*.rb']
      attr_reader :paths
    end

    db_dir = begin
               ActiveRecord::Tasks::DatabaseTasks.db_dir
             rescue NameError
               "./db"
             end
    @paths = [
      File.join(db_dir, 'views.rb'),
      File.join(db_dir, 'views', '*.rb'),
    ]

    #
    # Define a new schema. If you pass a block, it will be eval'd inside the Schema instance.
    #
    # @return [Viewmatic::Schema]
    #
    def self.define(&block)
      schema = new(&block)
      Viewmatic.schemas << schema
      schema
    end

    # @return [Array<Viewmatic::View] all defined views in this schema
    attr_reader :views

    #
    # Initialize a new schema. If you pass a block it will be eval'd inside the instance.
    #
    def initialize(&block)
      @views = {}
      @conn_proc = -> { ActiveRecord::Base.connection }
      instance_exec(&block) if block
    end

    #
    # Define a new view.
    #
    # @param name [Symbol] what to call the view
    #
    def view(name)
      view = views[name] = View.new(name)
      yield view if block_given?
      view
    end

    #
    # Override the default connection to use.
    #
    def connection(&block)
      @conn_proc = block if block
      @conn_proc
    end

    #
    # Create all views defined in this schema.
    #
    def load!
      conn = @conn_proc.call
      views.each do |_name, view|
        conn.execute SchemaStatements.create_view view
      end
    end

    #
    # Drop all views defined in this schema.
    #
    def drop!
      conn = @conn_proc.call
      views.each do |_name, view|
        conn.execute SchemaStatements.drop_view view
      end
    end
  end
end
