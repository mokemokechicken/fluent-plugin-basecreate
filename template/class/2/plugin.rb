class Fluent::!!CLASS_NAME!! < !!SUPER_CLASS_NAME!!
    Fluent::Plugin.register_output('!!FLUENT_TYPE_NAME!!', self)

    # config_param :hoge, :string, :default => 'hoge'
    config_param :buffer_path, :string, :default => '/tmp/buf_!!FLUENT_TYPE_NAME!!'

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

    def format(tag, time, record)
        [tag, time, record].to_msgpack
    end

    def write(chunk)
        records = []
        chunk.msgpack_each { |record|
            # records << record
        }
        # write records
    end
end
