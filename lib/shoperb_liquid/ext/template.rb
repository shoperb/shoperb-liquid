module Liquid
  class Template
    def self.parse(source, options = {})
      if source.kind_of?(Liquid::Template)
        source
      else
        template = Template.new
        template.parse(source, options)
        template
      end
    end
  end
end
