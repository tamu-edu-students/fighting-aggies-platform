#!/bin/bash -i
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'

check_install() {
    cmd="$1"
    good_msg="$2"
    bad_msg="$3"

    if command -v "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}$cmd $good_msg${NC}"
        return 1
    else
        echo -e "${RED}$cmd $bad_msg${NC}"
        return 0
    fi
    sleep 3
}

echo -e "${CYAN}Setting up... this should take 5-10 minutes${NC}"
sleep 5

echo -e "${YELLOW}Checking conflicting for conflicting yarn binary${NC}"
echo -e "${YELLOW}Don't worry if package is not already installed${NC}"
sleep 2
sudo apt remove cmdtest

# install apt dependencies
echo -e "${CYAN}Installing apt dependencies${NC}"
sleep 3
sudo apt -y update
sudo apt -y install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev  ffmpeg cucumber libpq-dev pkg-config postgresql
echo -e "${GREEN}apt dependencies successfully installed${NC}"
sleep 3


# installs rbevn
echo -e "${CYAN}Installing rbenv${NC}"
sleep 3
curl -fsSL 'https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer' | bash
echo -e 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo -e 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
check_install 'rbenv' 'successfully installed' 'failed to install'

# install google-chrome for cucumber testing
echo -e "${CYAN}Installing google-chrome for testing${NC}"
sleep 3
wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -fy
check_install 'google-chrome' 'successfully installed' 'failed to install'

retries=3
while [ $retries -gt 0 ]; do
  wget 'https://chromedriver.storage.googleapis.com/106.0.5249.61/chromedriver_linux64.zip'
  unzip chromedriver_linux64.zip
  sudo mv chromedriver /usr/bin/chromedriver
  sudo chown root:root /usr/bin/chromedriver
  sudo chmod +x /usr/bin/chromedriver
  install_status=$(check_install 'chromedriver' 'successfully installed' 'failed to install')
  if [ $install_status -eq 0 ]; then
    retries=$(( retries - 1 ))
    echo -e "${YELLOW}chromedriver failed to install trying again...${retries}/3${NC}"
  else
    break
  fi
done
check_install 'chromedriver' 'successfully installed' 'failed to install'

# install ruby
echo -e "${CYAN}Installing Ruby${NC}"
sleep 3

retries=3
while [ $retries -gt 0 ]; do
  LATEST_RUBY_VERSION=$(rbenv install --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+' | tail -1)
  rbenv install $LATEST_RUBY_VERSION -v
  rbenv global $LATEST_RUBY_VERSION
  rbenv local $LATEST_RUBY_VERSION
  ruby -v
  install_status=$(check_install 'ruby' 'successfully installed' 'failed to install')
  if [ $install_status -eq 0 ]; then
    retries=$(( retries - 1 ))
    echo -e "${YELLOW}ruby failed to install trying again...${retries}/3${NC}"
  else
    break
  fi
done
check_install 'ruby' 'successfully installed' 'failed to install'

source ~/.bashrc

# add extra gems
echo -e "${CYAN}Adding gems${NC}"
sleep 3
gem install selenium-webdriver -v 3.142.7
gem install rails 
echo -e "${GREEN}gems successfully added to Gemfile${NC}"
sleep 3

# update and install all gems
echo -e "${CYAN}Installing gems${NC}"
sleep 3
bundle update
bundle install
echo -e "${GREEN}gems successfully updated and installed${NC}"
sleep 3

echo -e "${CYAN}Installing npm${NC}"
sleep 3
sudo apt install -y npm
check_install 'npm' 'successfully installed' 'failed to install'

source ~/.bashrc

# add npm version manager 
echo -e "${CYAN}Installing yarn${NC}"
sleep 3
sudo npm install --global n
sudo n latest

# add yarn
sudo npm install --global yarn
yarn upgrade
yarn install
check_install 'yarn' 'successfully installed' 'failed to install'

# get newly installed commands
source ~/.bashrc

# migrate models and see dbs
echo -e "${CYAN}Updating ruby models and databases${NC}"
sleep 3
rake db:migrate
rake db:seed

# testing 
echo -e "${CYAN}Running unit tests${NC}"
sleep 3
rake cucumber
rspec

# clean up
echo -e "${CYAN}Cleaning up${NC}"

sleep 3
rm chromedriver_linux64.zip*
rm google-chrome-stable_current_amd64.deb*

echo -e "${GREEN}All setup processes COMPLETE!${NC}"

echo -e "${CYAN}If you have an error running bin/dev, source ~/.bashrc to update your paths${NC}"
