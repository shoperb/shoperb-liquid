# frozen_string_literal: true

class Array
  def to_liquid(*args)
    ShoperbLiquid::ArrayDrop.new(self)
  end
end
