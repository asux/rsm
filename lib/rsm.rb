require 'pathname'
require 'thor'
require 'thor/group'
require 'thor/util'

module Rsm
  autoload :Actions, 'rsm/actions'
  autoload :Runner, 'rsm/runner'
  autoload :Base, 'rsm/base'
  autoload :Unicorn, 'rsm/unicorn'

  module Install
    autoload :Nginx, 'rsm/install/nginx'
    autoload :Rails, 'rsm/install/rails'
  end
end
