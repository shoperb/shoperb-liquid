module Liquid
  class Context
    def handle_error(old_error, line_number = nil)
      e = old_error.is_a?(Liquid::Error) ? old_error : internal_error
      e.template_name ||= template_name
      e.line_number ||= line_number
      ShoperbLiquid.config.error_notify(old_error, e.template_name, e.line_number)
      errors.push(e)
      exception_renderer.call(e).to_s
    end
  end
end