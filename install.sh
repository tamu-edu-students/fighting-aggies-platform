#!/bin/bash -i
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'

check_install() {
    cmd="$1"
    good_msg="$2"
    bad_msg="$2"

    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}$cmd $good_msg${NC}"
    else
        echo -e "${RED}$cmd $bad_msg${NC}"
    fi
    sleep 1
}

echo -e "${CYAN}Go make a cup of coffee or somthing, this setup is going to take 5-10 minutes...${NC}"
sleep 5

echo -e "${YELLOW}Checking conflicting for conflicting yarn binary.${NC}"
sudo apt remove cmdtest

# install apt dependencies
echo -e "${CYAN}Installing apt dependencies${NC}"
sleep 1
sudo apt update
sudo apt install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev ffmpeg cucumber libpq-dev pkg-config npm
echo -e "${GREEN}apt dependencies successfully installed${NC}"
sleep 1

# installs rbevn
echo -e "${CYAN}Installing rbenv${NC}"
sleep 1
curl -fsSL 'https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer' | bash
echo -e 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo -e 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
check_install 'rbenv' 'rbenv successfully installed' 'rbenv failed to install'

# install chromedriver for cucumber testing
echo -e "${CYAN}Installing chromedrivers for testing${NC}"
sleep 1
wget 'https://chromedriver.storage.googleapis.com/106.0.5249.61/chromedriver_linux64.zip'
sudo unzip chromedriver_linux64.zip
sudo mv chromedriver /usr/bin/chromedriver
check_install 'chromedriver' 'chromedriver successfully installed' 'chromedriver failed to install'

# install google chrome for cucumber testing
wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo apt install ./google-chrome-stable_current_amd64.deb
check_install 'google-chrome' 'google-chrome successfully installed' 'google-chrome failed to install'

# install ruby
echo -e "${CYAN}Installing Ruby${NC}"
sleep 1
LATEST_RUBY_VERSION=$(rbenv install --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+' | tail -1)
rbenv install $LATEST_RUBY_VERSION -v
rbenv global $LATEST_RUBY_VERSION
rbenv local $LATEST_RUBY_VERSION
ruby -v
check_install 'ruby' 'ruby successfully installed' 'ruby failed to install'

# add extra gems
echo -e "${CYAN}Adding gems${NC}"
sleep 1
gem install selenium-webdriver -v 3.142.7
gem install rails 
echo -e "${GREEN}gems successfully added to Gemfile${NC}"
sleep 1

# update and install all gems
echo -e "${CYAN}Installing gems${NC}"
sleep 1
bundle update
bundle install
echo -e "${GREEN}gems successfully updated and installed${NC}"
sleep 1

# add npm 
echo -e "${CYAN}Installing npm${NC}"
sleep 1
sudo npm install --global n
sudo n latest
check_install 'npm' 'npm successfully installed' 'npm failed to install'

# add yarn
echo -e "${CYAN}Installing yarn and updating pacakges${NC}"
sleep 1
sudo npm install --global yarn
yarn upgrade
yarn install
check_install 'yarn' 'yarn successfully installed' 'yarn failed to install'

# get newly installed commands
source ~/.bashrc

# migrate models and see dbs
echo -e "${CYAN}Updating ruby models and databases${NC}"
sleep 1
rake db:migrate
rake db:seed

# testing 
echo -e "${CYAN}Running unit tests${NC}"
sleep 1
rake cucumber
rspec

# clean up
echo -e "${CYAN}Cleaning up${NC}"
sleep 1
rm chromedriver_linux64.zip*
rm google-chrome-stable_current_amd64.deb*

# refresh
source ~/.bashrc

echo -e "${CYAN}All setup processes complete!${NC}"
sleep 1
echo -e "${CYAN}If you have an error running bin/dev, source ~/.bashrc to update your paths${NC}"
