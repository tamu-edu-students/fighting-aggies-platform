# xargs -a package-list.txt apt-get -y install # install apt packages and their dependencies
sudo dpkg --set-selections < package-list.txt
sudo apt-get -y update
sudo apt-get dselect-upgrade

# Install rbenv and ruby-build
sudo apt-get update
sudo apt-get install -y git autoconf rbenv ruby-build 
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

# Install the latest version of Ruby
LATEST_RUBY_VERSION=$(rbenv install --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+' | tail -1)
rbenv install $LATEST_RUBY_VERSION

ruby-build -v $LATEST_RUBY_VERSION
rbenv global $LATEST_RUBY_VERSION
rbenv local $LATEST_RUBY_VERSION

# Verify the installation
ruby -v

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
