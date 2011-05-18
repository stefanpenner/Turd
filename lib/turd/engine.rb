module Turd
  class Engine < Rails::Engine
    initializer 'turd.initialize' do
      ActiveSupport.on_load(:action_controler) do
        # do something eventually
      end

      ActiveSupport.on_load(:action_view) do
        # do something eventually
        # ActionView::Template.register_template_handler :doc, Turd::TemplateHandler.new
      end
    end
  end
end
