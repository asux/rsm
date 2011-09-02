# 0.1.rc2 / TBA

  * Added support of auth__basic in Nginx config
  * Added support of www-subdomain rewriting in Nginx config
  * Option `domain` now is absolute

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
