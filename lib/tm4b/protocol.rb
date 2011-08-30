
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
  end

end