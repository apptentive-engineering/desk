module Desk
  class Client
    # Defines methods related to labels
    module Label
      # Returns extended information of labels
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.labels
      #     Desk.labels(:count => 5)
      #     Desk.labels(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/labels
      def labels(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        response = get("labels",options)
        response
      end

      # Returns extended information on a single label
      #
      #   @param id [Integer] a label ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.label(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/labels/show
      def label(id)
        response = get("labels/#{id}")
        response.label
      end

    end
  end
end