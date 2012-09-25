Fluent Plugin Base Create
=============

This is a utility to setup Fluent Plugin Development Environment.
It implemnts the method of [http://d.hatena.ne.jp/tagomoris/20120221/1329815126](hhttp://d.hatena.ne.jp/tagomoris/20120221/1329815126) .


Requirement
-----------

* Ruby >= 1.9.2
* Bundler (gem install bundler)
* Fluentd (gem install fluentd)
* git


Usage
------

```
git clone https://github.com/mokemokechicken/fluent-plugin-basecreate.git
bash fluent-plugin-basecreate/fluent-plugin-basecreate.bash
```

Then, input 

* plugin gem name (ex. fluent-plugin-status200counter)
* fluent type name (ex. status200counter)
* Plugin Class Name (ex. Status200CounterOutput)
* Plugin Super Class

Like bellow.

```
plugin gem name (ex. fluent-plugin-status200counter)? fluent-plugin-moketest
fluent type name (ex. status200counter)? moketest
Plugin Class Name (ex. Status200CounterOutput)? MokeTestOutput
Plugin Super Class
[0] Fluent::Input
[1] Fluent::BufferedOutput
[2] Fluent::TimeSlicedOutput
[3] Fluent::Output
Select Super Class (ex. 2)? 1
================================================
plugin gem name is [fluent-plugin-moketest]
fluent type name is [moketest]
Plugin Class Name is [MokeTestOutput]
Plugin Super Class Name is [Fluent::BufferedOutput]
OK (y/n) ? y
```

Enter 'y'

```
      create  fluent-plugin-moketest/Gemfile
      create  fluent-plugin-moketest/Rakefile
      create  fluent-plugin-moketest/LICENSE.txt
      create  fluent-plugin-moketest/README.md
      create  fluent-plugin-moketest/.gitignore
      create  fluent-plugin-moketest/fluent-plugin-moketest.gemspec
      create  fluent-plugin-moketest/lib/fluent-plugin-moketest.rb
      create  fluent-plugin-moketest/lib/fluent-plugin-moketest/version.rb
Initializating git repo in /home/k_morishita/work/fluent-plugin-moketest
[master (root-commit) 7fa4bff] fluent-plugin-basecreate.bash's commit
 9 files changed, 231 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 Gemfile
 create mode 100644 LICENSE.txt
 create mode 100644 README.md
 create mode 100644 Rakefile
 create mode 100644 fluent-plugin-moketest.gemspec
 create mode 100644 lib/fluent/plugin/buf_moketest.rb
 create mode 100644 test/helper.rb
 create mode 100644 test/plugin/test_buf_moketest.rb
```

if success, you can run rake test.

```
$ cd fluent-plugin-moketest
$ rake test
/home/k_morishita/.rvm/rubies/ruby-1.9.3-p194/bin/ruby -I"lib:lib:test" -I"/home/k_morishita/.rvm/gems/ruby-1.9.3-p194@global/gems/rake-0.9.2.2/lib" "/home/k_morishita/.rvm/gems/ruby-1.9.3-p194@global/gems/rake-0.9.2.2/lib/rake/rake_test_loader.rb" "test/**/test_*.rb" 
Run options: 

# Running tests:

...

Finished tests in 0.028020s, 107.0665 tests/s, 0.0000 assertions/s.

3 tests, 0 assertions, 0 failures, 0 errors, 0 skips
```

tree result
----------

```
$ tree fluent-plugin-moketest
fluent-plugin-moketest
├── Gemfile
├── LICENSE.txt
├── README.md
├── Rakefile
├── fluent-plugin-moketest.gemspec
├── lib
│   └── fluent
│       └── plugin
│           └── buf_moketest.rb
└── test
    ├── helper.rb
    └── plugin
        └── test_buf_moketest.rb
```


Acknowledgement
---------------

Special thanks to tagomoris!

