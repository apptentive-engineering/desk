module Desk
  class Client
    # Defines methods related to inbound mailboxes
    module Mailbox
      # Returns extended information of inbound mailboxes
      #
      #   @option options [Boolean, String, Integer]
      #   @example Return extended information for 12345
      #     Desk.inbound_mailboxes
      #     Desk.inbound_mailboxes(:count => 5)
      #     Desk.inbound_mailboxes(:count => 5, :page => 3)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/inbound-mailboxes
      def inbound_mailboxes(*args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        get("mailboxes/inbound", options)
      end

      # Returns extended information on a single inbound mailbox
      #
      #   @param id [Integer] a inbound mailbox ID
      #   @option options [Hash]
      #   @example Return extended information for 12345
      #     Desk.inbound_mailbox(12345)
      # @format :json
      # @authenticated true
      # @see http://dev.desk.com/docs/api/inbound-mailboxes/show
      def inbound_mailbox(id)
        response = get("mailboxes/inbound/#{id}")
        response.inbound_mailbox
      end
    end
  end
end