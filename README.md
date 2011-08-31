RSM -- Rails Server Manger
==========================

RSM created for make easier some actons on server like:

  * generation config file
  * manipulation of files
  * running commands

This version can:

  * create Nginx virtual server config from template
  * automaticly enable Nginx virtual server config
  * clone from Git repo or download and unpack Rails application from TGZ or TBZ2 archive
  * start and stop unicorn server

Homepage
--------

Project located at GitHub: https://github.com/asux/rsm

Author
------

Created by Oleksandr (asux) Ulianytskyi

License
-------

Source code has MIT license

Installation
------------

Install from RubyGems:

  $ gem install rsm --pre

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