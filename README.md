# iProfero

Suite of agency management tools.

## Features

* Built on the MEAN stack (Mongo, Express, Angular, Node)
* Automatically generated styleguide at /styleguide
* Analytics
* Login via social networks
* User roles
* Unit, Midway, and E2E testing

## How to

Install: `npm install`
Run: `npm start` or `grunt`
Test: `npm test` or `karma start` (client)
View: [http://localhost:3000](http://localhost:3000)

**NOTE: You need to download Angular separately and put in the `public/lib`folder. Bower will only install Angular version 1.0.8 but the app requires version 1.1.5**

## Prerequisites
* Node.js - Download and Install [Node.js](http://www.nodejs.org/download/). You can also follow [this gist](https://gist.github.com/isaacs/579814) for a quick and easy way to install Node.js and npm.
* MongoDB - Download and Install [MongoDB](http://www.mongodb.org/downloads) - Make sure it's running on the default port (27017) before you start the app.

## Quick Deployment
4 commands to deploy your mean app to heroku,
Before you start make sure you have <a href="https://toolbelt.heroku.com/">heroku toolbelt</a> installed and an accessible mongo db instance - you can try <a href="http://www.mongohq.com/">mongohq</a> which have an easy setup )

```bash
git init
git add .
git commit -m "initial version"
heroku apps:create
git push heroku master
heroku config:set NODE_ENV=production
```

## Configuration
All configuration is specified in the [config](config/) folder, particularly the [config.coffee](config/config.coffee) file. Here are all the social app keys for integration with Twitter, Facebook, GitHub, Google, Linkedin, and Weibo.

### Environmental Settings

There are three environments, __development__, __test__, and __production__. Each of these environments has the following configuration options:
* db - This is the name of the MongoDB database to use, and is set by default to __mean-dev__ for the development environment.
* root - This is determined automatically at the start of this file, but can be overridden here.
* app.name - This is the name the app, and can be different for each environment. You can tell which environment you are running by looking at the TITLE attribute that the app generates.
* Social Registration - Facebook, GitHub, Google, Twitter, Linkedin. Need to specify your own social accounts here for each social platform, with the following for each provider:
	* clientID
	* clientSecret
	* callbackURL

To run with a different environment, just specify NODE_ENV as you call grunt:

	$ NODE_ENV=development grunt
	$ NODE_ENV=test grunt

If you are using node instead of grunt, it is very similar:

	$ NODE_ENV=test node start

> NOTE: Running Node.js applications in the __production__ environment enables caching, which is disabled by default in all other environments.

To run in production mode:
	
	$ NODE_ENV=production grunt production

## Todo

There's a .TODO file with bugs

## Screenshots

![Home page](https://www.dropbox.com/s/sj2vzhv4xadql5a/1-home.png "Home page")
![Sign up page](https://www.dropbox.com/s/tjlt5kmur047c4q/2-signup.png "Sign up page")
![Login page](https://www.dropbox.com/s/qr1yui9vbpxpmc8/3-login.png "Login page")
![Off-canvas Sidebar Menu](https://www.dropbox.com/s/sudnlepogbqjdt2/4-sidebar.png "Off-canvas Sidebar Menu")
![Welcome page](https://www.dropbox.com/s/3dcbu5xf9tw06qc/5-welcome.png "Welcome page")
![Welcome page 2](https://www.dropbox.com/s/10xt58ercfdgyvn/6-welcome.png "Welcome page 2")
![Welcome page 3](https://www.dropbox.com/s/0yzch1c48t83s3r/7-welcome.png "Welcome page 3")
![Dashboard](https://www.dropbox.com/s/wo8imigyj2rkg7p/8-dashboard.png "Dashboard")
![People page](https://www.dropbox.com/s/8fxjpqbghvh2pa1/9-people.png "People page")
![Profile page](https://www.dropbox.com/s/qlrm1et7dbqddqc/10-profile.png "Profile page")
![Edit-in-place fields](https://www.dropbox.com/s/a8t3ssl5y1wn0a9/11-edit-in-place.png "Edit-in-place fields")
![Edit-in-place-fields](https://www.dropbox.com/s/gbmwmd8o3g5sdb1/12-edit-in-place.png "Edit-in-place-fields")
![Edit-in-place fields](https://www.dropbox.com/s/qnqki8aqvgwwx7f/13-edit-in-place.png "Edit-in-place fields")
![Change Avatar Modal](https://www.dropbox.com/s/gfr2jjqi87uxsh5/14-upload-avatar.png "Change Avatar Modal")
![Projects page](https://www.dropbox.com/s/gfr2jjqi87uxsh5/14-upload-avatar.png "Projects page")
![Project page](https://www.dropbox.com/s/jpnso0c8lfbtkl5/16-project.png "Project page")
![Create/Edit Project page](https://www.dropbox.com/s/jwz6w8fygn7gxfu/17-edit-project.png "Create/Edit Project page")
![Create Project page 2](https://www.dropbox.com/s/999v8hthnmhggwk/18-edit-project.png "Create Project page 2")
![Create Project page 3](https://www.dropbox.com/s/8g0v347zmb96nrk/19-edit-project.png "Create Project page 3")
![Timesheet Tracker 1](https://www.dropbox.com/s/1kj7n1k3wxdsazj/20-timesheets.png "Timesheet Tracker 1")
![Timesheet Tracker 2](https://www.dropbox.com/s/5d8brjv8slry5fz/21-timesheets.png "Timesheet Tracker 2")
![Timesheet Tracker 3](https://www.dropbox.com/s/2e1owqbvd8nbpy3/22-timesheets.png "Timesheet Tracker 3")
![Timesheet Tracker 3](https://www.dropbox.com/s/xqio0epw4itqt2p/23-timesheets.png "Timesheet Tracker 3")
![Timesheet Tracker 5](https://www.dropbox.com/s/7k6m47yyxyfch87/24-timesheets.png "Timesheet Tracker 5")
![Timesheet Tracker 6](https://www.dropbox.com/s/yxqt7qinutlsadl/25-timesheets.png "Timesheet Tracker 6")
![Timesheet Tracker 7](https://www.dropbox.com/s/mu0w23ys7o2xvxm/26-timesheets.png "Timesheet Tracker 7")
![Admin Settings page](https://www.dropbox.com/s/7z7ohoqkdk51gvm/27-admin-settings.png "Admin Settings page")
![Admin Settings page 2](https://www.dropbox.com/s/o2sbgepuieqlaii/28-admin-settings.png "Admin Settings page 2")
![Admin Settings page 3](https://www.dropbox.com/s/5jjggjie5ga0e1g/29-admin-settings.png "Admin Settings page 3")
![New page](https://www.dropbox.com/s/5k9qyytdknhj8e4/30-new-page.png "New page")
![Styleguide](https://www.dropbox.com/s/8hacgq2wnbx79zi/31-styleguide.png "Styleguide")
![Styleguide 2](https://www.dropbox.com/s/f05oeh0pmn1pxf9/32-styleguide.png "Styleguide 2")

## Credits
Based on [Mean.io](https://mean.io/)

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
