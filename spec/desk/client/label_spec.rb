require 'helper'

describe Desk::Client do
  Desk::Configuration::VALID_FORMATS.each do |format|
    context ".new(:format => '#{format}')" do
      before do
        @client = Desk::Client.new(:subdomain => "example", :format => format, :consumer_key => 'CK', :consumer_secret => 'CS', :oauth_token => 'OT', :oauth_token_secret => 'OS')
      end

      describe ".labels" do
        context "lookup" do
          before do
            stub_get("labels.#{format}").
              to_return(:body => fixture("labels.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.labels
            a_get("labels.#{format}").
              should have_been_made
          end

          it "should return up to 100 labels worth of extended information" do
            labels = @client.labels
            labels.results.should be_a Array
            labels.results.last.label.id.should == 2
            labels.results.last.label.name.should == "Administrators"
          end
        end
      end

      describe ".label" do
        context "lookup" do
          before do
            stub_get("labels/1.#{format}").
              to_return(:body => fixture("label.#{format}"), :headers => {:content_type => "application/#{format}; charset=utf-8"})
          end

          it "should get the correct resource" do
            @client.label(1)
            a_get("labels/1.#{format}").
              should have_been_made
          end

          it "should return up to 100 cases worth of extended information" do
            label = @client.label(1)
            label.id.should == 1
            label.name.should == "Sales"
          end
        end
      end
    end
  end
end