# 0.1.5 / September 06, 2011
  
  * Changed virtual host config filename for Nginx. It's now domain-based instead of name-based.

# 0.1.4 / September 06, 2011

  * Added `rsm:unicorn:restart` task

# 0.1.3 / September 04, 2011

  * Using socket_per_worker in nginx upstream server config

# 0.1.2 / September 04, 2011

  * Added support of Thin server: generate config, start/stop/restart
  * Fixed domain from hostname

# 0.1.1 / September 04, 2011

  * Added `rsm:bundle:install` and `rsm:bundle:update` tasks
  * Added `--verbose` [`-V`] option
  * Default destionation root is application root

# 0.1 / September 03, 2011

  * Added support of auth_basic in Nginx config
  * Added support of www-subdomain rewriting in Nginx config
  * Option `domain` now is absolute (or use `hostname -f`)

# 0.1.rc1 / August 31, 2011

  * Refactored tasks heirarchy
  * Fixed class options in `Rsm::Base`
  * Unicorn: added `start` and `stop` commands

# 0.1.beta4 / August 31, 2011

  * `unicorn` command as method in `Runner`
  * Added `environment` option for unicorn

# 0.1.beta3 / August 31, 2011

  *yanked*

# 0.1.beta2 / August 31, 2011

  * Some code moved to `Rsm::Install::Base`
  * Nginx config template uses `application_root` variable
  * Changed injection in nginx.conf
  * Command `unicorn` accepts environment option
  * Capistrano-aware `application_root`

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
