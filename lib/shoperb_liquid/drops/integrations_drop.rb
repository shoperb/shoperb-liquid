# frozen_string_literal: true

module ShoperbLiquid
  class IntegrationsDrop < CollectionDrop
    def head
      collection["head"]
    end

    def start_body
      collection["start_body"]
    end

    def end_body
      collection["end_body"]
    end
  end
end
