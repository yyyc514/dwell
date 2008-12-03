require "#{File.dirname(__FILE__)}/recipes/ubuntu"
require "#{File.dirname(__FILE__)}/recipes/apache"
require "#{File.dirname(__FILE__)}/recipes/mysql"
require "#{File.dirname(__FILE__)}/recipes/svn"
require "#{File.dirname(__FILE__)}/recipes/git"
require "#{File.dirname(__FILE__)}/recipes/ruby"
require "#{File.dirname(__FILE__)}/recipes/gems"
require "#{File.dirname(__FILE__)}/recipes/passenger"

require "#{File.dirname(__FILE__)}/recipes/linode"
require "#{File.dirname(__FILE__)}/recipes/imagemagick"
require "#{File.dirname(__FILE__)}/recipes/daemontools"
require "#{File.dirname(__FILE__)}/recipes/tinydns"
require "#{File.dirname(__FILE__)}/recipes/rails_app"

Capistrano::Configuration.instance(:must_exist).load do 
  namespace :dwell do
    
    set :dwell_install, []
    
    desc "Install Rails Production Environment"
    task :install do
      top.dwell.ubuntu.prepare
      top.dwell.apache.install
      top.dwell.mysql.install
      top.dwell.svn.install
      top.dwell.git.install
      top.dwell.ruby.install
      top.dwell.gems.install
      top.dwell.passenger.install
      dwell_install.each do |package_name|
        top.dwell.send(package_name).install
      end
    end
  
  end
end
