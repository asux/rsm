RSM -- Rails Server Manger
==========================

RSM created for make easier some actons on server like:

  * generation config file
  * manipulation of files
  * running commands

This version can:

  * create Nginx virtual server config from template
  * clone from Git repo or download and unpack Rails application from TGZ or TBZ2 archive
  * generate Unicorn config from template
  * start/stop/restart *unicorn* server
  * start/stop/restart *thin* server
  * run bundle install and update

Homepage
--------

Project located at GitHub: https://github.com/asux/rsm

Author
------

Created by Oleksandr (asux) Ulianytskyi

License
-------

Source code has BSD license

Installation
------------

Install from RubyGems:

    $ gem install rsm

Or from source code:

    $ git clone git://github.com/asux/rsm
    $ cd rsm
    $ rake install

Ussage
-----

List avalable tasks:

    $ rsm -T

Help for certain task:

    $ rsm help TASK

Documentation
-------------

For detailed documentation read YARD docs at Rubydoc - http://rubydoc.info/gems/rsm/frames
or generated from GitHub - http://rubydoc.info/github/asux/rsm/master/frames