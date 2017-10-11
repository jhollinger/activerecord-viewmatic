module Viewmatic
  module SchemaStatements
    def self.create_view(v)
      mat = v.materialized ? 'MATERIALIZED' : nil
      cols = v.column_names ? "(#{v.column_names.join ', '})" : nil
      %Q(CREATE #{mat} VIEW #{v.name} #{cols} AS #{v.query})
    end

    def self.drop_view(v)
      mat = v.materialized ? 'MATERIALIZED' : nil
      %Q(DROP #{mat} VIEW IF EXISTS #{v.name})
    end
  end
end
