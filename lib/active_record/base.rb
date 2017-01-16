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
      # [:id./........]

      if columns.include?(name)
        @attributes[name]
      else
        super
      end
    end

    def self.find(value)
      attributes =
        connection.execute("SELECT * FROM #{table_name} WHERE id=#{value.to_int}").first
      new(attributes)
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
