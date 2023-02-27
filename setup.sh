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
    
}

echo -e "${CYAN}Setting up... this should take 5-10 minutes${NC}"
echo -e "${YELLOW}Checking conflicting for conflicting yarn binary${NC}"
echo -e "${YELLOW}Don't worry if package is not already installed${NC}"
sudo apt remove cmdtest

# install apt dependencies
echo -e "${CYAN}Installing apt dependencies${NC}"
sudo apt -y update
sudo apt -y install git curl autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev  ffmpeg cucumber libpq-dev pkg-config
echo -e "${GREEN}apt dependencies successfully installed${NC}"

# installs rbevn
RBENV=$(which rbenv)
if [ -z "$RBENV" ]; then
  echo -e "${CYAN}Installing rbenv${NC}"
  
  curl -fsSL 'https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer' | bash
  echo -e 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo -e 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc
  check_install 'rbenv' 'successfully installed' 'failed to install'
else
  echo -e "${GREEN}$(rbenv --version) is installed${NC}"
fi

# install google-chrome for cucumber testing
CHROME=$(which google-chrome)
if [ -z "$CHROME" ]; then
  echo -e "${CYAN}Installing google-chrome for testing${NC}"
  
  wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt-get install -fy
  check_install 'google-chrome' 'successfully installed' 'failed to install'
  rm google-chrome-stable_current_amd64.deb*
else
  echo -e "${GREEN}$(google-chrome --version) is installed${NC}"
fi

DRIVER=$(which chromedriver)
if [ -z "$DRIVER" ]; then
  wget 'https://chromedriver.storage.googleapis.com/106.0.5249.61/chromedriver_linux64.zip'
  unzip chromedriver_linux64.zip
  sudo mv chromedriver /usr/bin/chromedriver
  sudo chown root:root /usr/bin/chromedriver
  sudo chmod +x /usr/bin/chromedriver
  check_install 'chromedriver' 'successfully installed' 'failed to install'
  rm chromedriver_linux64.zip*
else
  echo -e "${GREEN}$(chromedriver --version) is installed${NC}"
fi

RUBY=$(which ruby)
if [ -z "$RUBY" ]; then
  echo -e "${CYAN}Installing Ruby${NC}"
  LATEST_RUBY_VERSION=$(rbenv install --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+' | tail -1)
  rbenv install -s $LATEST_RUBY_VERSION -v
  rbenv local $LATEST_RUBY_VERSION
  check_install 'ruby' 'successfully installed' 'failed to install'
else
  echo -e "${GREEN}$(ruby --version) is installed${NC}"
fi

# add extra gems
echo -e "${CYAN}Adding gems${NC}"
gem install selenium-webdriver -v 3.142.7
gem install rails 
echo -e "${GREEN}gems successfully added to Gemfile${NC}"

# update and install all gems
echo -e "${CYAN}Installing gems${NC}"
bundle config set --local without 'production'
bundle install
echo -e "${GREEN}gems successfully updated and installed${NC}"

echo -e "${CYAN}Installing npm${NC}"
sudo apt install -y npm
check_install 'npm' 'successfully installed' 'failed to install'

# add npm version manager 
echo -e "${CYAN}Installing yarn${NC}"
sudo npm install --global n
sudo n latest

# add yarn
sudo npm install --global yarn
yarn upgrade
yarn install
check_install 'yarn' 'successfully installed' 'failed to install'

# load schema and seed db
echo -e "${CYAN}Updating ruby models and databases${NC}"
rails db:setup
rails db:schema:dump
rails db:test:load

# clean up
echo -e "${CYAN}Cleaning up${NC}"
echo -e "${GREEN}All setup processes complete.${NC}"
echo -e "${CYAN}If you have an error running bin/dev, source ~/.bashrc to update your paths${NC}"
