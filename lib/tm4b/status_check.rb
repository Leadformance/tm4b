# encoding: utf-8

require 'rexml/document'
require 'date'

module TM4B
   class StatusCheck
      attr_accessor :sms_id, :custom, :status, :timestamp

      def parameters
         params = {
            "version" => "2.1",
            "type" => "check_status"
         }

         if sms_id
            params["smsid"] = sms_id 
         else
            params["custom"] = custom
         end

         params
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
   end
end