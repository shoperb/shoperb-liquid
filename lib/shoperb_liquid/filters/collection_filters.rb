module ShoperbLiquid
  module CollectionFilters

    def with_custom_field(input, name, value, leave_blank=true)
      ary = Liquid::StandardFilters::InputIterator.new(input, context)

      ary.select do |el|
        hash_value = el.custom_fields[name]
        if hash_value
          if hash_value["set_values"] == []
            leave_blank 
          else
            hash_value["set_values"].include?(value)
          end
        else
          # if true and not present, then leacing in collection
          leave_blank 
        end
      end
      # filter_array(input, property, target_value) { |ary, &block| ary.select(&block) }
    end

  end
end
