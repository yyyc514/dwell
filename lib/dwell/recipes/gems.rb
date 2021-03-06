Capistrano::Configuration.instance(:must_exist).load do 
  namespace :dwell do
    namespace :gems do
  
      set :rails_gem_version, nil
  
      desc "Install RubyGems"
      task :install_rubygems do
        run "mkdir -p src"
        run "cd src && wget http://rubyforge.org/frs/download.php/45905/rubygems-1.3.1.tgz"
        run "cd src && tar xzf rubygems-1.3.1.tgz"
        run "cd src/rubygems-1.3.1 && sudo ruby setup.rb"
        run "sudo ln -sf /usr/bin/gem1.8 /usr/bin/gem"
        run "cd ~/ && sudo rm -rf src"
        dwell1.record_install "rubygems"
      end
  
      desc "Install Gems"
      task :install_gems do
        sudo "gem install rails -v#{rails_gem_version} --no-rdoc --no-ri" if rails_gem_version
        sudo "gem install rails capistrano rspec passenger mysql rdoc merb --no-rdoc --no-ri"
        dwell1.record_install "default_gems"
      end
  
      desc "Installation"
      task :install do
        install_rubygems
        install_gems
      end

    end
  end
end