require 'rexml/document'

module TM4B
   class StatusCheck
      attr_accessor :sms_id, :custom, :status, :timestamp

      def parameters
         {
            "version" => "2.1",
            "type" => "check_status",
            "smsid" => sms_id,
            "custom" => custom
         }
      end

      def raw_response=(body)
         document = REXML::Document.new(body)

         values = REXML::XPath.first(document, '/result/report/child::text()').value.split("|")

         @status = values[0]
         @timestamp = DateTime.strptime(values[1], "%Y%m%d%H%M")
      end
   end
end