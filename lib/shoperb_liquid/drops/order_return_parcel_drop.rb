# frozen_string_literal: true

module ShoperbLiquid
  class OrderReturnParcelDrop < Base
    def id
      record.id
    end
    
    def provider
      record.provider
    end
    
    def barcode
      record.barcode
    end
    
    def state
      record.state
    end
    
    def filename
      record.filename
    end
    
    def url
      record.url
    end
  end
end
