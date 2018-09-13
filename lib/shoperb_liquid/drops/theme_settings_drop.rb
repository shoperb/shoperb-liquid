# frozen_string_literal: true

module ShoperbLiquid
  class ThemeSettingsDrop < Base
    attr_reader :settings

    def initialize(custom_settings={})
      @settings = custom_settings

      settings.each do |key, value|
        define_singleton_method key do
          if image = image_object(key)
            ThemeSectionImageDrop.new(image)
          else
            format_value(key, value)
          end
        end
      end
    end

    def self.invokable?(method_name)
      true
    end

    def method_missing(*args)
      nil
    end

    private

    def format_value(key, value)
      value
    end

    def image_object(handle)
      image_id = settings_images[handle]
      images.detect { |i| i.id == image_id.to_i } if image_id
    end

    def images
      @images ||= Image.includes(:image_sizes).where(id: image_ids)
    end

    def image_ids
      settings_images.values
    end

    def settings_images
      Hash[settings.map do |handle, value|
        if match = value.to_s.match(image_regex)
          [handle, match[:id]]
        end
      end.compact].compact
    end

    def image_regex
      /shoperb_image:\/\/id:(?<id>\d+)\/\/(.+)/
    end
  end
end
