# frozen_string_literal: true

module ShoperbLiquid
  class CountryDrop < Base
    def code
      record.code
    end

    def name
      record.name
    end

    def iso3
      record.iso3
    end

    def numeric
      record.numeric
    end

    def eu
      record.eu
    end

    def na
      record.na
    end

    def abstract
      record.abstract
    end

    def states_json
      record.states.as_json(only: [:name, :code])
    end
  end
end
