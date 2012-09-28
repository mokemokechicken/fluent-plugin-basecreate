#!/bin/bash

GEM=`which gem`
GIT=${GIT_PATH:=`which git`}
BUNDLE=${BUNDLE_PATH:=`which bundle`}
THIS_DIR=$(cd $(dirname $0); pwd)
TEMPLATE_DIR=${TEMPLATE_DIR:=${THIS_DIR}/template}

check_environment () {
    [ ! -d "$TEMPLATE_DIR" ] && echo "${TEMPLATE_DIR} is not directory" && exit 1
    [ ! -x "$GEM" ] && echo "gem not found in your PATH." && exit 1
    [ ! -x "$GIT" ] && echo "git not found in your PATH." && exit 1
    $GEM list -i bundler > /dev/null; [ "$?" != "0" ] && echo "please install 'bunlder' by 'gem install bundler'" && exit 1
    $GEM list -i fluentd > /dev/null; [ "$?" != "0" ] && echo "please install 'fluentd' by 'gem install fluentd'" && exit 1
    [ ! -x "$BUNDLE" ] && echo "bundle not found in your PATH." && exit 1
}


input_arg () {
    RET=""
    while [ -z "$RET" ];
    do
        echo -n "$1"
        read RET
    done
}

input_args () {
    ###
    input_arg "plugin gem name (ex. fluent-plugin-status200counter)? "
    GEM_NAME=$RET
    ###
    input_arg "fluent type name (ex. status200counter)? "
    FLUENT_TYPE_NAME=$RET
    ###
    input_arg "Plugin Class Name (ex. Status200CounterOutput)? "
    CLASS_NAME=$RET
    ###
    PLUG_TYPE=(in out out out)
    CS=(Fluent::Input Fluent::BufferedOutput Fluent::TimeSlicedOutput Fluent::Output)
    TS=(InputTestDriver BufferedOutputTestDriver BufferedOutputTestDriver OutputTestDriver)
    while [ -z "$SUPER_CLASS_NAME" ];
    do
        echo "Plugin Super Class"
        echo "[0] ${CS[0]}"
        echo "[1] ${CS[1]}"
        echo "[2] ${CS[2]}"
        echo "[3] ${CS[3]}"
        input_arg "Select Super Class (ex. 2)? "
        SUPER_CLASS_TYPE=$RET
        SUPER_CLASS_NAME=${CS[$SUPER_CLASS_TYPE]}
        TEST_SUPER_CLASS_NAME=${TS[$SUPER_CLASS_TYPE]}
        PLUG_TYPE_NAME=${PLUG_TYPE[$SUPER_CLASS_TYPE]}
    done
    ###
    echo "================================================"
    echo "plugin gem name is [$GEM_NAME]"
    echo "fluent type name is [$FLUENT_TYPE_NAME]"
    echo "Plugin Class Name is [$CLASS_NAME]"
    echo "Plugin Super Class Name is [$SUPER_CLASS_NAME]"
    input_arg "OK (y/n) ? "
    [ "$RET" != "y" ] && echo "please retry" && exit 1
    return 0
}

copy_template () {
    FROM=$1
    TO=$2
    cat $FROM \
        | sed "s|!!FLUENT_TYPE_NAME!!|${FLUENT_TYPE_NAME}|g" \
        | sed "s|!!CLASS_NAME!!|${CLASS_NAME}|g" \
        | sed "s|!!SUPER_CLASS_NAME!!|${SUPER_CLASS_NAME}|g" \
        | sed "s|!!TEST_SUPER_CLASS_NAME!!|${TEST_SUPER_CLASS_NAME}|g" \
        | sed "s|!!PLUGIN_DIR_IN_LIB!!|${PLUGIN_DIR_IN_LIB}|g" \
        | sed "s|!!PLUGIN_FILENAME!!|${PLUGIN_FILENAME}|g" \
        > $TO
}


check_environment
input_args

#############
PLUGIN_DIR_IN_LIB=fluent/plugin
PLUGIN_LIB_DIR=lib/${PLUGIN_DIR_IN_LIB}
PLUGIN_TEST_DIR=test/plugin
PLUGIN_FILENAME=${PLUG_TYPE_NAME}_${FLUENT_TYPE_NAME}.rb
PLUGIN_TEST_FILENAME=test_${PLUGIN_FILENAME}
#############
set -e -a
$BUNDLE gem $GEM_NAME
cd $GEM_NAME
mkdir -p $PLUGIN_LIB_DIR
mv lib/${GEM_NAME}.rb ${PLUGIN_LIB_DIR}/${PLUGIN_FILENAME}
rm lib/${GEM_NAME}/version.rb
rmdir lib/${GEM_NAME}
mkdir -p ${PLUGIN_TEST_DIR}
touch ${PLUGIN_TEST_DIR}/${PLUGIN_TEST_FILENAME}
##############
TEMPLATE_TYPE_DIR=${TEMPLATE_DIR}/class/${SUPER_CLASS_TYPE}
CLASS_TEMPLATE=${TEMPLATE_TYPE_DIR}/plugin.rb
TEST_CLASS_TEMPLATE=${TEMPLATE_TYPE_DIR}/test.rb
HELPER_TEMPLATE=${TEMPLATE_DIR}/helper.rb

copy_template $CLASS_TEMPLATE ${PLUGIN_LIB_DIR}/${PLUGIN_FILENAME}
copy_template $TEST_CLASS_TEMPLATE ${PLUGIN_TEST_DIR}/${PLUGIN_TEST_FILENAME}
copy_template $HELPER_TEMPLATE test/helper.rb
cat ${TEMPLATE_DIR}/Rakefile_add >> Rakefile
cat ${TEMPLATE_DIR}/.gitignore .gitignore | sort | uniq > .tmp; mv .tmp .gitignore

### Update gemspec
SPEC_FILE=${GEM_NAME}.gemspec
cat ${SPEC_FILE} \
    | sed "/^require '/d" \
    | sed "/^end$/d" \
    | sed "/::VERSION$/d" \
    > .tmp
cat<<"EOM">>.tmp

  gem.version       = '0.0.1'
  gem.add_development_dependency "fluentd"
  gem.add_runtime_dependency "fluentd"
end
EOM
mv .tmp ${SPEC_FILE}
### Git
git add .
git commit -a -m "fluent-plugin-basecreate.bash's commit"

