module ActiveRecord
  class Base
    def self.abstract_class=(value)
      # Not impelemted
    end

    def initialize(attributes = {})
      @attributes = attributes
    end


    def method_missing(name, *args)
      columns = self.class.connection.columns(self.class.table_name)

      if columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.find(value)
      find_by_sql("SELECT * FROM #{table_name} WHERE id=#{value.to_i}").first
    end

    def self.all
      Relation.new(self)
    end

    def self.where(*args)
      all.where(*args)
    end

    def self.order(*args)
      all.order(*args)
    end

    def self.find_by_sql(sql)
      connection.execute(sql).map do |attributes|
        new(attributes)
      end
    end

    def self.establish_connection(options)
      @@connection = ConnectionAdapter::SqliteAdapter.new(options[:database])
    end

    def self.connection
      @@connection
    end

    def self.table_name
      name.downcase + "s"
    end
  end
end
