# Integration testing

Continuous integration testing is very useful for biogems/plugins. The Ruby
community has come up with [travis-ci](http://about.travis-ci.org/), which is
integrated into github!  Any time code is submitted to github, the automated
testing on different platforms kicks in. 

Here we set out to set up travis-ci with a biogem. I chose my bio-gff3 gem 
for integrated testing.

## Setting up Travis-CI

The online documentation is rather complete. Here we just list the steps needed
for a biogem.

First set up an account using Github OAuth. Click the sign-in with github button in the top
right corner of the travis-ci website. Choose the github projects you want to test for.

Next add a .travis.yml configuration file to the repository. It lists the Rubies to
test against. Lets test all versions:

```yaml
language: ruby
rvm:
  - 1.8.7
  - 1.9.2
  - 1.9.3
  - jruby-18mode # JRuby in 1.8 mode
  - jruby-19mode # JRuby in 1.9 mode
  - rbx-18mode
  - rbx-19mode
# uncomment this line if your project needs to run something other than `rake`:
# script: bundle exec rspec spec
```

Test the file with

```bash
gem install travis-lint
travis-lint 
Hooray, .travis.yml at /export/local/users/pjotr/git/opensource/ruby/bioruby-gff3/.travis.yml seems to be solid!
```

Pushing any changes to github should kick in all testing!

You know what? Tests failed. Rubinius did lot like the rcov native extension,
which got installed by older editions of biogem. So time to remove that. JRuby
was fussy about 'NameError: uninitialized constant BIN', which was actually
correct, and should not have passed in MRI.

Ruby 1.9.3 complained about
  
```bash
  /home/vagrant/.rvm/rubies/ruby-1.9.3-p125/lib/ruby/1.9.1/test/unit.rb:167:in 'block in non_options': file not found: test/**/test_*.rb (ArgumentError)
```

Funny that. On my machine all tests passed. On travis all builds failed, even on the same 
Ruby interpreter. I had to disable my regression tests because Travis does not like resolving
paths to external programs (surprise!).

Anyway, fixing these bugs/issues made it a better gem!

To add a status button on github, add the following to your README.md

```
  [![Build Status](https://secure.travis-ci.org/[YOUR_GITHUB_USERNAME]/[YOUR_PROJECT_NAME].png)](http://travis-ci.org/[YOUR_GITHUB_USERNAME]/[YOUR_PROJECT_NAME])
```

If you check the README of

  https://github.com/pjotrp/bioruby-gff3-plugin

You can see 'build status: passing' (as of 27/2/2012).

Clicking on the button takes the viewer directly to the test results!

Ready to run for all Ruby editions. We will add these buttons to
http://biogems.info/.  Also, we would like to achieve that any time a gem is
tagged for release, the automated testing on different platforms kicks in. 

This is amazing functionality. 
