require 'date'
require 'digest/md5'
require 'json'
require 'hashie/mash'
require 'active_support/inflector'
require 'faraday'

require 'uatu/version'
require 'uatu/resources'

require 'uatu/endpoints/single'
require 'uatu/endpoints/collection'
require 'uatu/endpoints/nested'

require 'uatu/base'

require 'uatu/response'
require 'uatu/configuration'
require 'uatu/connection'
require 'uatu/resource'
require 'uatu/error'

module Uatu
  extend Uatu::Configuration
end

