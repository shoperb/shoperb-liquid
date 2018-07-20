# frozen_string_literal: true

module ShoperbLiquid
  class SectionTag < ::Liquid::Include
    def render(context)
      context.stack do
        unless settings = context.registers[:theme].settings_data
          raise ShoperbLiquid::Error, "No settings data for theme"
        end

        section_id = context.evaluate(@template_name_expr)
        section_data = settings.data["sections"][section_id]
        context["section"] = ThemeSectionDrop.new(section_id, section_data)

        super
      end
    end

    private

    # taken from "include" tag, changed a call to file system
    def read_template_from_file_system(context)
      Liquid::Template.file_system.read_section_file(
        context.evaluate(@template_name_expr)
      )
    end
  end
end
