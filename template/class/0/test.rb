require 'helper'

class !!CLASS_NAME!!Test < Test::Unit::TestCase
    def setup
        Fluent::Test.setup
    end

    CONFIG = %[
    ]
    # CONFIG = %[
    #   path #{TMP_DIR}/out_file_test
    #   compress gz
    #   utc
    # ]

    def create_driver(conf = CONFIG, tag='test')
        Fluent::Test::!!TEST_SUPER_CLASS_NAME!!.new(Fluent::!!CLASS_NAME!!, tag).configure(conf)
    end

    def test_configure
        #### set configurations
        # d = create_driver %[
        #   path test_path
        #   compress gz
        # ]
        #### check configurations
        # assert_equal 'test_path', d.instance.path
        # assert_equal :gz, d.instance.compress
    end
end
