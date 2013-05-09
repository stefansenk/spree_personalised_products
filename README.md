Spree Personalised Products
===========================

[![Build Status](https://travis-ci.org/stefansenk/spree_personalised_products.png)](https://travis-ci.org/stefansenk/spree_personalised_products)

Adds support for personalised products to Spree. In the admin you can assign personalisation options to variants, this could be either the master variant or standard variants. The personalisation options consist primarily of a name and max length of characters. When the customer views a product they are presented with the personalisation input fields, which they must fill in before adding the item to the cart. 

The personalisation details they entered are displayed by the line item in their shopping cart and in the admin. To change the personalisation details the customer must delete the product and add it again. A personalised product can be added to the cart multiple times, as it could be bought with different personalisation options.


Installation
============

Append to your Gemfile:

    gem 'spree_personalised_products', :git => 'git://github.com/stefansenk/spree_personalised_products.git'

Run:

    $ bundle install
    $ rake railties:install:migrations
    $ rake db:migrate


Testing
=======

Run:

	$ cd spree_personalised_products
    $ bundle
    $ bundle exec rake test_app
    $ bundle exec spork
    $ bundle exec rspec spec


Screenshots
===========

Product page:

![Screenshot](https://raw.github.com/stefansenk/spree_personalised_products/master/screenshot-product.png)

Product admin page:

![Screenshot](https://raw.github.com/stefansenk/spree_personalised_products/master/screenshot-admin.png)


TODO
====

- Allow editing the personalisation details for a line item in the admin.
- Allow customer to select options from a list of values. Currently only supports input as a text field.
- Allow adding multiple variants with personalisations to the cart at once. Currently personalisation only works adding one variant at a time.
- Allow personalised orders to be placed through the API.
- Fix or remove the controller specs.
	

Copyright (c) 2012 Stefan Senk, released under the New BSD License
