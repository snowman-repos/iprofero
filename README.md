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

![Home page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.37.03.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNy4wMy5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTQxfQ%3D%3D--1a62268af252640da4bcedf66e90ed405567a245 "Home page")
![Sign up page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.37.19.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNy4xOS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTQyfQ%3D%3D--c99acc3aaf896688aa8faa51ecc668038153e9a5 "Sign up page")
![Login page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.37.29.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNy4yOS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTQ0fQ%3D%3D--92e7facdde25ce553ed38772506d9a7e29b4c6a8 "Login page")
![Welcome page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.38.07.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zOC4wNy5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTQ2fQ%3D%3D--8659fef62e8ad4e464737bbe7d2345163f78af4c "Welcome page")
![Welcome page 2](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.38.21.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zOC4yMS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTQ3fQ%3D%3D--cf2afc8e6d1de1d9e2ca135301179bb4a77275da "Welcome page 2")
![Welcome page 3](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.38.31.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zOC4zMS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTUwfQ%3D%3D--20cd903b5fda7f91027e0a0f0e8584d16bc8836b "Welcome page 3")
![Dashboard](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.21.54.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yMS41NC5wbmciLCJleHBpcmVzIjoxMzg0NTE4MjEzfQ%3D%3D--d379ec68b818f19b67d8b098dca5facb9bce114d "Dashboard")
![Off-canvas Sidebar Menu](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.22.16.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yMi4xNi5wbmciLCJleHBpcmVzIjoxMzg0NTE4MzAxfQ%3D%3D--6625a477fbe21515b13ba9e92bf1ee58ab7a8b0d "Off-canvas Sidebar Menu")
![People page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.22.24.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yMi4yNC5wbmciLCJleHBpcmVzIjoxMzg0NTE4MzA0fQ%3D%3D--49844f39658bf0cbf5b151ffe20125d0d9f33e4c "People page")
![Profile page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.27.54.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yNy41NC5wbmciLCJleHBpcmVzIjoxMzg0NTE4MzQyfQ%3D%3D--f20ad92ce7196a92931a4dd341179e7de7c44c4b "Profile page")
![Edit-in-place fields](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.28.15.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOC4xNS5wbmciLCJleHBpcmVzIjoxMzg0NTE4MzY0fQ%3D%3D--ae6e795bb2aa88ddfb87778f29b44319aad2ea03 "Edit-in-place fields")
![Edit-in-place-fields](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.28.29.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOC4yOS5wbmciLCJleHBpcmVzIjoxMzg0NTE4MzY5fQ%3D%3D--64269ab017844508ff5e489f02b0f486f4be0b53 "Edit-in-place-fields")
![Edit-in-place fields](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.28.37.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOC4zNy5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDA1fQ%3D%3D--92e8d76c6f3a49545c9451b6761ffdb17ff401ea "Edit-in-place fields")
![Change Avatar Modal](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.28.42.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOC40Mi5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDA3fQ%3D%3D--8c1a6365f87324b0c75d2d78f82b89b48791b402 "Change Avatar Modal")
![Projects page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.28.50.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOC41MC5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDA5fQ%3D%3D--7788a9ebe49e414b1fd38cc5dd5de738f15ad567 "Projects page")
![Project page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.28.59.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOC41OS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDQyfQ%3D%3D--1ea8804ffad33847918c2c55e2410f63cb805cd1 "Project page")
![Create/Edit Project page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.29.57.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4yOS41Ny5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDQzfQ%3D%3D--e473a03ea9d6c92de250d158f6967666f4ec9fa1 "Create/Edit Project page")
![Create Project page 2](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.31.07.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zMS4wNy5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDQ3fQ%3D%3D--b44698a6399e8755ccd67485b1fd53ea7a2f028b "Create Project page 2")
![Create Project page 3](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.31.18.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zMS4xOC5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDUwfQ%3D%3D--633be692b390bab9cd90cb80640f9c1035468c5d "Create Project page 3")
![Timesheets page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.35.51.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNS41MS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NDkzfQ%3D%3D--838781cb137da3febc8f0299393fbb95bd324ab2 "Timesheets page")
![Admin Settings page](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.36.14.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNi4xNC5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTA3fQ%3D%3D--4eff0dbd635387f01d87e5ac83d1685660d144f8 "Admin Settings page")
![Admin Settings page 2](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.36.28.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNi4yOC5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTA5fQ%3D%3D--1abafa02fb28097088d22e439363e8323cf4b7f7 "Admin Settings page 2")
![Admin Settings page 3](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2016.36.49.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNi4zNi40OS5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTExfQ%3D%3D--3ae933fec4814c99dbc2296f6a7e51a00b706e34 "Admin Settings page 3")
![Styleguide](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2017.01.02.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNy4wMS4wMi5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTUyfQ%3D%3D--a4d3afe6c2bc989ec07ce456dfd32a06a1a3f769 "Styleguide")
![Styleguide 2](https://raw.github.com/Profero-China/nodeproject/master/screenshots/Screen%20Shot%202013-11-08%20at%2017.01.20.png?token=2296711__eyJzY29wZSI6IlJhd0Jsb2I6UHJvZmVyby1DaGluYS9ub2RlcHJvamVjdC9tYXN0ZXIvc2NyZWVuc2hvdHMvU2NyZWVuIFNob3QgMjAxMy0xMS0wOCBhdCAxNy4wMS4yMC5wbmciLCJleHBpcmVzIjoxMzg0NTE4NTU0fQ%3D%3D--cf0be9b6a578a94dd3f63f7915509b9381f6545b "Styleguide 2")

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
