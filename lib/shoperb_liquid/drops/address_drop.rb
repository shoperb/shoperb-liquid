# frozen_string_literal: true

module ShoperbLiquid
  class AddressDrop < Base
    def name
      record.name
    end

    def first_name
      record.first_name
    end

    def last_name
      record.last_name
    end

    def full_name
      record.full_name
    end

    def company
      record.company
    end

    def company?
      record.account_type == "company"
    end

    # def email
    #   record.email
    # end

    def phone
      record.phone
    end

    def full_address
      record.full_address
    end

    def company_with_phone
      record.company_with_phone
    end

    def city_state_with_zip
      record.city_state_with_zip
    end

    def street
      record.full_address
    end

    def address1
      record.address1
    end

    def address2
      record.address2
    end

    def city
      record.city
    end

    def state
      record.state_name
    end

    def country
      record.country_name
    end

    def state_code
      record.state.try(:code)
    end

    def country_code
      record.country.try(:code)
    end

    # return only for address customer
    # if have id then showing edit/update path
    # if id not present, then create path.
    # This is for simplicity of theme creators
    def url
      if record.type == "AddressCustomer"
        if record.id
          routes.store_address_path(record)
        else
          routes.store_addresses_path
        end
      end
    end
  end
end
