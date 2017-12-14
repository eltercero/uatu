require 'date'
require 'digest/md5'
require 'json'
require 'hashie/mash'
require 'active_support/inflector'
require 'faraday'

require 'uatu/response'
require 'uatu/configuration'
require 'uatu/connection'
require 'uatu/resource'
require 'uatu/version'
require 'uatu/error'

require 'uatu/base'

module Uatu
  extend Uatu::Configuration
end

