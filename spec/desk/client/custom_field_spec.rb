require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".custom_fields" do
        context "lookup" do
          before do
            stub_get("custom_fields.#{format}").
              to_return(:body => fixture("custom_fields.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.custom_fields
            a_get("custom_fields.#{format}").
              should have_been_made
          end

          it "should return up to 100 custom_fields worth of extended information" do
            custom_fields = @client.custom_fields
            custom_fields.results.should be_a Array
            custom_fields.results.last.custom_field.id.should == 2
            custom_fields.results.last.group.name.should == "Administrators"
          end
        end
      end

      describe ".custom_field" do
        context "lookup" do
          before do
            stub_get("custom_fields/1.#{format}").
              to_return(:body => fixture("custom_field.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.custom_field(1)
            a_get("custom_fields/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            custom_field = @client.custom_field(1)
            custom_field.id.should == 1
            custom_field.name.should == "Sales"
          end
        end
      end
    end
  end
end