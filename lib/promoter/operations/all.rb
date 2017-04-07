module Promoter
  module Operations
    module All
      def self.included(klass)
        klass.extend(ClassMethods)
      end

      module ClassMethods
        def all(opts = {}, client = Promoter.shared_client)
          opts = Utils.serialize_values(opts)
          json = client.get_json(path, opts)
          results = json.delete(:results)
          collection = EnumerableResourceCollection.new(results.map { |attributes| new(attributes) })
          collection.meta = json
          collection
        end
      end
    end
  end
end
