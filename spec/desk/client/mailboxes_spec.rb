require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".inbound_mailboxes" do
        context "lookup" do
          before do
            stub_get("inbound_mailboxes.#{format}").
              to_return(:body => fixture("inbound_mailboxes.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.inbound_mailboxes
            a_get("mailboxes/inbound.#{format}").
              should have_been_made
          end

          it "should return up to 100 inbound_mailboxes worth of extended information" do
            inbound_mailboxes = @client.inbound_mailboxes
            inbound_mailboxes.results.should be_a Array
            inbound_mailboxes.results.last.inbound_mailbox.id.should == 2
            inbound_mailboxes.results.last.inbound_mailbox.email.should == "another_support@example.com"
          end
        end
      end

      describe ".inbound_mailbox" do
        context "lookup" do
          before do
            stub_get("mailboxes/inbound/1.#{format}").
              to_return(:body => fixture("inbound_mailbox.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.inbound_mailbox(1)
            a_get("mailboxes/inbound/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            inbound_mailbox = @client.inbound_mailbox(1)
            inbound_mailbox.id.should == 1
            inbound_mailbox.name.should == "Sales"
          end
        end
      end
    end
  end
end