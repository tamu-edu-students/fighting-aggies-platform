# xargs -a package-list.txt apt-get -y install # install apt packages and their dependencies
 sudo dpkg --set-selections < package-list.txt
 sudo apt-get -y update
 sudo apt-get dselect-upgrade

# sudo apt install rbenv
# rbenv init
# echo "eval '$(~/.rbenv/bin/rbenv init - ba)'" >> ~/.bashrc

# rbenv install 3.2.0
# rbenv global 3.2.0
# rbenv local 3.2.0
#
# bundle update
# bundle install
#
# sudo apt update # might not be necessary
# sudo apt install nodejs
# node -v
#
# sudo apt remove cmdtest
# sudo apt install yarn
# yarn
#
# rake db:migrate
# rake db:seed
#
# cucumber -q --tags "not @skip"
# rspec
