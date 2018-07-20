# frozen_string_literal: true

module ShoperbLiquid
  module ThemeFilters
    #
    # returns content with values
    # taken from settins
    #
    def customize(asset_path, settings_drop)
      Theme.current.assets.find_by(
        file: asset_path
      ).customize(
        settings_drop,
        host: ShoperbLiquid.config.assets_remote_host
      )
    end

    def image_size(image, size)
      (image[size].try(:url) if image) || image
    end
  end
end
