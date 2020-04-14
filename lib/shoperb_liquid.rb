# frozen_string_literal: true

require "liquid"
require "pagy"
require "active_support/all"
require "shoperb_liquid/configuration"
require "shoperb_liquid/registers"
require "shoperb_liquid/errors"
autoload :ActionView, "action_view"

module ShoperbLiquid
  def self.configure
    yield(config)
  end

  def self.config
    @config ||= ShoperbLiquid::Configuration.new
  end

  def self.env
    config.environment
  end

  def self.autoload_all(mod, folder)
    Gem.find_files("#{folder}/*.rb").each { |path| require path }
  end

  def self.options(context, **options)
    Registers.options(context, **options)
  end

  ShoperbLiquid.autoload_all self, "shoperb_liquid/ext"
  ShoperbLiquid.autoload_all self, "shoperb_liquid/filters"
  ShoperbLiquid.autoload_all self, "shoperb_liquid/tags"

  require "shoperb_liquid/drops/base"
  require "shoperb_liquid/drops/collection_drop"

  ShoperbLiquid.autoload_all self, "shoperb_liquid/drops"

  Registers.register_filters
  Registers.register_tags

  class Template < Liquid::Template; end

end
