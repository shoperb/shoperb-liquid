# frozen_string_literal: true

module ShoperbLiquid
  class IntegrationDrop < Base
    def id
      record.id
    end

    def name
      record.name
    end

    def handle
      record.handle
    end

    def code_layout
      Liquid::Template.parse(record.code["layout"]).render({ "record" => record.settings })
    end

    def count
      integrations.count
    end
  end
end
