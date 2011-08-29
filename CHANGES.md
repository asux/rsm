# 0.1.beta1 / August 30, 2011

  * Methods in `Rsm::Actions` use `name` attribute
  * Using autload instead of require
  * Updated gemsepc. Added Gemfile, Rakefile

# 0.1.alpha2 / August 29, 2011

  * Splitted Nginx and Rails application tasks
  * Using relative paths
  * Fixed application root in unicorn template

# 0.1.alpha1 / August 28, 2011

  * Created tasks:
    - create Nginx virtual server config from template
    - enable Nginx virtual server config
    - clone or download and unpack Rails application from TGZ or TBZ2 archive
    - set permission for Rails application
    - create Unicorn config from template
    - run unicorn server
