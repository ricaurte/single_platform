require "single_platform/version"

module SinglePlatform
  def self.config
    @config ||= Configuration.new
  end
end

require 'active_support/core_ext/string/inflections'
require 'single_platform/configuration'
require 'single_platform/url_signing'
require 'single_platform/request'
require 'single_platform/location'
require 'single_platform/menu'
require 'single_platform/menu_section'
require 'single_platform/menu_item'
