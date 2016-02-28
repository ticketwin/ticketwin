module Sparta
  module Controller
    private

    def sparta_action_params
      return @sparta_action_params if @sparta_action_params

      if sparta_params.respond_to?(sparta_action)
        @sparta_action_params = sparta_params.send(sparta_action)
      else
        @sparta_action_params = sparta_params.default
      end
    end

    alias_method :params!, :sparta_action_params

    def sparta_params
      @sparta_params ||= sparta_params_class.new(params)
    end

    def sparta_params_class
      formatted_class = params[:controller].to_s.split('/').last.singularize.camelize
      @sparta_params_class ||= "#{formatted_class}Parameters".constantize
    end

    def sparta_action
      @sparta_action ||= params[:action]
    end
  end
end
