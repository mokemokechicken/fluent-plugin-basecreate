class Fluent::!!CLASS_NAME!! < !!SUPER_CLASS_NAME!!
    Fluent::Plugin.register_output('!!FLUENT_TYPE_NAME!!', self)

    # config_param :hoge, :string, :default => 'hoge'

    def initialize
        super
        # require 'hogepos'
    end

    def configure(conf)
        super
        # @path = conf['path']
    end

    def start
        super
        # init
    end

    def shutdown
        super
        # destroy
    end

    # This method is called when an event is reached.
    # 'es' is a Fluent::EventStream object that includes multiple events.
    # You can use 'es.each {|time,record| ... }' to retrieve events.
    # 'chain' is an object that manages transaction. Call 'chain.next' at
    # appropriate point and rollback if it raises exception.
    def emit(tag, es, chain)
        chain.next
        es.each {|time,record|
        }
    end
end
