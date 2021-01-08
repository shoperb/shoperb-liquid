# frozen_string_literal: true

module ShoperbLiquid
  class SectionTag < ::Liquid::Include
    # liquid >=5
    class PartialCache
      def self.load(template_name, context:, parse_context:)
        cached_partials = (context.registers[:cached_partials] ||= {})
        cached = cached_partials[template_name]
        return cached if cached

        file_system = (context.registers[:file_system] ||= Liquid::Template.file_system)
        # source      = file_system.read_template_file(template_name) # original
        source      = file_system.read_section_file(template_name)    # new

        parse_context.partial = true

        template_factory = (context.registers[:template_factory] ||= Liquid::TemplateFactory.new)
        template = template_factory.for(template_name)

        partial = template.parse(source, parse_context)
        cached_partials[template_name] = partial
      ensure
        parse_context.partial = false
      end
    end

    # liquid >= 5.0
    # taken from "include" tag, changed a call to file system
    def render_to_output_buffer(context, output)
      template_name = context.evaluate(@template_name_expr)
      raise ArgumentError, options[:locale].t("errors.argument.include") unless template_name

      # new code
      unless settings = context.registers[:theme].settings_data
        raise ShoperbLiquid::Error, "No settings data for theme"
      end

      section_id = context.evaluate(@template_name_expr)
      section_data = settings.data["sections"][section_id]
      context["section"] = ThemeSectionDrop.new(section_id, section_data)
      # end of new code

      partial = PartialCache.load( # need this line here
        template_name,
        context: context,
        parse_context: parse_context
      )

      context_variable_name = @alias_name || template_name.split('/').last

      variable = if @variable_name_expr
        context.evaluate(@variable_name_expr)
      else
        context.find_variable(template_name, raise_on_not_found: false)
      end

      old_template_name = context.template_name
      old_partial       = context.partial
      begin
        context.template_name = template_name
        context.partial       = true
        context.stack do
          @attributes.each do |key, value|
            context[key] = context.evaluate(value)
          end

          if variable.is_a?(Array)
            variable.each do |var|
              context[context_variable_name] = var
              partial.render_to_output_buffer(context, output)
            end
          else
            context[context_variable_name] = variable
            partial.render_to_output_buffer(context, output)
          end
        end
      ensure
        context.template_name = old_template_name
        context.partial       = old_partial
      end

      output
    end

    # liquid < 5.0
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

    # liquid < 5.0
    # taken from "include" tag, changed a call to file system
    def read_template_from_file_system(context)
      Liquid::Template.file_system.read_section_file(
        context.evaluate(@template_name_expr)
      )
    end
  end
end
