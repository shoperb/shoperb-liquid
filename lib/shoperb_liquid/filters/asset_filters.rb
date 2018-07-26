module ShoperbLiquid
  module AssetFilters
    include ActionView::Helpers::AssetTagHelper

    def stylesheet_tag(url, media=:screen)
      check_asset_defined_in_spec(url, :stylesheets)

      tag :link, rel: :stylesheet, type: Mime::CSS, media: media, href: url
    end

    def javascript_tag(url)
      check_asset_defined_in_spec(url, :javascripts)

      content_tag :script, "", type: Mime::JS, src: url
    end

    def icon_tag(url)
      tags = ""
      tags << tag(:link, rel: "icon", type: "image/vnd.microsoft.icon", href: url)
      tags << "\n"
      tags << tag(:link, rel: "shortcut icon", href: url)
    end

    def image_tag(url, alt=nil, title=nil)
      tag :img, alt: h(alt), src: url, title: h(title)
    end

    def style_tag(data, id=nil)
      content_tag :style, data, type: "text/css", id: id
    end

    def asset_url(path)
      ShoperbLiquid.config.file_system.absolute_asset_path(path)
    end

    # legacy
    def preview_asset_url(path)
      asset_url(path)
    end

    private

    def check_asset_defined_in_spec(url, type)
      return unless ShoperbLiquid.env.theme_development?

      relative_url = url.gsub(/\/system\/assets\/#{type}\//, "")

      unless (compiled_assets[type] || []).include?(relative_url)
        raise ShoperbLiquid::Error, "#{type.to_s.singularize.titleize} #{relative_url} is not defined in SPEC, but served"
      end
    end

    def compiled_assets
      @compiled_assets ||= (@context.registers[:theme].spec.try(:compile) || {}).symbolize_keys
    end
  end
end
