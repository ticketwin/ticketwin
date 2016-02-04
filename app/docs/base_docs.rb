module BaseDocs
  def self.included(host)
    host.extend Apipie::DSL::Concern
    host.extend ClassMethods

    resource_name = host.name.gsub(/Docs$/,'')

    host.define_singleton_method(:superclass) { "Api::V1::#{resource_name}Controller".constantize }
    host.resource_description { resource_id resource_name }
  end

  module ClassMethods
    def spec(method, &block)
      block.call
      define_method(method) { nil }
    end
  end
end
