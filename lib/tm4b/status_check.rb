# encoding: utf-8

require 'rexml/document'
require 'date'

module TM4B
   class StatusCheck

      VERSION = "2.1"
      TYPE = "check_status"
      
      attr_accessor :sms_id, :custom, :status, :timestamp

      def initialize(args)
        @sms_id = args[:sms_id]
        @custom = args[:custom_data]
      end

      def parameters
         {"version" => VERSION, "type" => TYPE, "smsid" => sms_id, "custom" => custom}.delete_if { |k, v| !v }
      end

      def raw_response=(body)
         document = REXML::Document.new(body)

         values = REXML::XPath.first(document, '/result/report/child::text()').value.split("|")

         @status = values[0]
         @timestamp = values[1] ? DateTime.strptime(values[1], "%y%m%d%H%M") : nil
      end

      def to_s
         "TM4B::StatusCheck\n" + %w(sms_id custom status timestamp).map {|x| "\t#{x}: #{send(x)}" }.join("\n")
      end

      def valid?
        !!(sms_id || custom)
      end
   end
end
