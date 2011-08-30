
module TM4B
  
  module Protocol
    SplitMethods = {
      :no_split               => 0,
      :simple_strict          => 1,
      :simple_graceful        => 2,
      :sms_numbering_strict   => 3,
      :sms_numbering_graceful => 4,
      :three_dots_strict      => 5,
      :three_dots_graceful    => 6,
      :concatenation_strict   => 7,
      :concatenation_graceful => 8
    }

    EncodingTypes = [:plain, :unicode]

    ErrorCodes = {
      1 => "The value for a mandatory parameter could not be found",
      2 => "The account's credentials could not be verified",
      3 => "An unsupported version of the SMS API has been requested",
      4 => "An invalid value has been supplied",
      5 => "The destination country cannot be identified",
      6 => "An invalid combination of values has been supplied",
      7 => "An invalid HTTP method has been used",
      8 => "The ratio of messages to recipients is not valid",
      9 => "The maximum number of recipients has been exceeded",
      10 => "Insufficient credits on the relevant balance",
      12 => "The specified subscription service has expired",
      13 => "An attempt to send MT SMS to a non-test number before the subscription has gone live",
      14 => "The requested keyword is not available on any shared number"
    }
  end

end