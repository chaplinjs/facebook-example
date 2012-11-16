![Chaplin](http://s3.amazonaws.com/imgly_production/3401027/original.png)

# Example Facebook Application built with Chaplin.js

This is a small example application built with [Chaplin.js](https://github.com/chaplinjs/chaplin), an application structure on top of Backbone.js. It can be used as a boilerplate.

While traditional site login using e-mail and password is still around, single sign-on gained popularity. The example application features a client-side OAuth 2.0 login with [Facebook Connect](https://developers.facebook.com/docs/reference/javascript/FB.login/). Facebook is just a sample service provider. In a [separate repository](https://github.com/chaplinjs/chaplin-auth), you will find code for client-side login using [Google APIs Client Library](http://code.google.com/p/google-api-javascript-client/) and [Twitter Anywhere](https://dev.twitter.com/docs/anywhere/welcome)

This example uses a Facebook application named “Chaplin Example App”. On login, you will be asked to grant access rights to this Facebook app. Of course this app will not post anything to Facebook on your behalf or publish/submit your personal data. You’re free to [revoke access rights](https://www.facebook.com/settings/?tab=applications) at any time. You might easily [create your own Facebook App](https://developers.facebook.com/apps) and change the app ID in `coffee/lib/services/facebook.coffee`.

## Running the Example

The original sources are written in CoffeeScript (`coffee/` directory), but this repository already comes with the compiled JavaScripts (`js/` directory). To recompile the CoffeeScripts, you might run the command line [CoffeeScript compiler](http://coffeescript.org/) in the repository’s root directory:

```
coffee --bare --output js/ coffee/
```

This repository also contains a copy of the Chaplin library in `js/vendor/chaplin.js`.

Since Facebook apps are always bound to a specific domain, the login only works if the app runs on the (nonexistent) domain `chaplin.moviepilot.com`. To access the application, follow these steps:

- Add the line `127.0.0.1   chaplin.moviepilot.com` to your [hosts file](http://en.wikipedia.org/wiki/Hosts_%28file%29).
- Start a simple local HTTP server (like [nginx](http://nginx.org/) for example), point the document root to the app directory.
- Then you’re able to access *http://chaplin.moviepilot.com/* in your browser and log in with Facebook.

After successful login, your Facebook likes are fetched from the Open Graph and displayed as a list. You might click a list entry to see more details.

Besides the likes browsers, there’s a second screen which displays some latest posts on the moviepilot.com Facebook page. This is just another controller in order to demonstrate the change between controllers with proper routing and cleanup.

## Architectural Documentation

### Directory Structure

This example has a standard Chaplin MVC directory structure:

- `coffee/models`
- `coffee/views`
- `coffee/controllers`
- `coffee/libs`

All vendor libraries like jQuery and Backbone are located `js/vendor/`.

### Application Startup

There are two special files which are responsible for the application bootstrap:

- `coffee/facebook_application.coffee`
- `coffee/routes.coffee`

`facebook_application.coffee` is the application root class which inherits from `Chaplin.Application`. It starts up all Chaplin core modules and starts the routing. It is loaded and instantiated in `index.html`.

`routes.coffee` contains all application routes which map URLs to controller actions.

### Templating

Since Chaplin is template-engine agnostic, you have to decide which templating solution you want to use and how you want to load the templates. This example uses [Handlebars](http://handlebarsjs.com/) templates and loads them on-demand using the [RequireJS Text](http://requirejs.org/docs/api.html#text) plugin.

Chaplin expects that views implement the `getTemplateFunction` method which needs to return the actual templating function. Since all views in this example use the same templating solution, `getTemplateFunction` is provided once by two base classes all other views inherit from:

- `coffee/views/base/view.coffee`
- `coffee/views/base/collection_view.coffee`

The actual `.hbs` template files are located in the `js/templates` directory.

### Application-specific Extensions

To ease the development, this repository also provides application-specific base classes for models, collections and controllers. They inherit from the Chaplin base classes:

- `coffee/models/base/model.coffee`
- `coffee/models/base/collection.coffee`
- `coffee/controllers/base/controller.coffee`

Furthermore, `coffee/lib/support.coffee` and `coffee/lib/utils.coffee` demonstrate how to extend the feature testing and utility files of Chaplin.

Last but not least, this example uses a specific `Layout` class which can be found in `coffee/views/layout.coffee`.

## [The Cast](https://github.com/chaplinjs/chaplin/blob/master/AUTHORS.md#the-cast)

## [The Producers](https://github.com/chaplinjs/chaplin/blob/master/AUTHORS.md#the-producers)
