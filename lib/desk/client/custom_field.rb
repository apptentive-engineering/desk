module Desk
  class Client
    # Defines methods related to custom fields
    module CustomField
      # Returns extended information of custom fields
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.custom_fields
      #     Desk.custom_fields(:count => 5)
      #     Desk.custom_fields(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/custom_fields
      def custom_fields(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("custom_fields",options)
      end

      # Returns extended information on a single custom field
      #
      #   @param id [Integer] a custom field ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.custom_field(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/custom_fields/show
      def custom_field(id)
        response = get("custom_fields/#{id}")
        response.custom_field
      end

    end
  end
end