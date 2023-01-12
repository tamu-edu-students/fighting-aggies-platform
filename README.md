# Fightin Aggies Platform

Developing an analytical panel to generate insights that help facilitate the post-game analysis done by the coaches and players of Fightin Texas Aggies Football team.

### Deployment - [Heroku](https://fightin-aggies.herokuapp.com/)

### Installation and Running Instructions
```bash
git clone https://github.com/jessefphipps/fighting-aggies-platform.git
```
```bash
cd fighting-aggies-platform
```
```bash
./install.sh
```
```bash
~/.bashrc
```
```bash
bin/dev
```

If you are developing on a server on a remote machine (e.g., AWS/EC2) use *http://0.0.0.0:8080* as your host url
and on your local machine use the EC2 instance's public IPv4 address in place of *0.0.0.0*.

If you are using vscode's remote editing feature use *localhost* as the broadcast IP and vscode will portforward 
the instance's public IP and allow you to access the machine using your localhost (you can acccess the remote 
server's webpages and APIs by going to http://localhost:8080 on your local machine).

The server's broadcast IP (-b) and port (-p) can be set in *Procfile.dev*.

### Testing Instructions
Run the server in your local machine and use a new terminal to run the tests using the commands given below,
```bash
cucumber -q
rspec
```
### Heroku Deployment Instructions
Migrate and seed the database
```bash
heroku run rake db:migrate
heroku run rake db:seed
```
Install ffmpeg on heroku
```bash
heroku buildpacks:add --index 1 https://github.com/jonathanong/heroku-buildpack-ffmpeg-latest.git
bundle install
yarn
git add .
git commit -m "ffmpeg buildpack on heroku"
git push heroku main
```
### One Time Link Email
Email: fighting.aggies.analytics@gmail.com

App Password: tsaqzyyqbplvzcaa 

This is not the password for the email.


If having issues, to create new email:

Enable 2-step verification. Must be turned on to avoid getting the emails blocked by Google.

To create an app password, go to your Google account settings and navigate to the "Security" tab. Under "Signing in to Google", click on the "App passwords" menu item (this will only be available if you have 2-step verification turned on). Next, select Other (Custom name) under the "Select app" dropdown and enter the name of your app or something else useful. Click "Generate" and your new app password will appear on the screen. Make sure you copy it before closing the window, or you won't be able to see the password again.


When using application in development mode, the one time link is in the terminal. When using the application in production mode, the one time email will be sent to the email address of the user.

### Enabling Google OAuth for Website

