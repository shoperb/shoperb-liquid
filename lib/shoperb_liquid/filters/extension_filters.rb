# frozen_string_literal: true

module ShoperbLiquid
  #
  # Translating of strings in the theme
  #
  module ExtensionFilters
    def sort(input, property = nil)
      if input.is_a?(Hash)
        # replacing values
        property = 0 if property == "key"
        property = 1 if property == "value"
        
        ret = if property
          input.sort{|a,b| nil_safe_compare(a[property],b[property])}.to_h
        else
          input.sort{|a,b| nil_safe_compare(a,b)}.to_h
        end
        return ret
      end
      super
    end
    
    def nil_safe_compare(a, b)
      a = a.to_s if a.is_a?(Array)
      b = b.inspect if b.is_a?(Array)
      if !a.nil? && !b.nil?
        a <=> b
      else
        a.nil? ? 1 : -1
      end
    end

  end
end
