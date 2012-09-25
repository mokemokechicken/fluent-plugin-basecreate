class Fluent::!!CLASS_NAME!! < !!SUPER_CLASS_NAME!!
    Fluent::Plugin.register_input('!!FLUENT_TYPE_NAME!!', self)

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

end
