module Turd
  # An object from BlankSlate simply discards all messages sent to it.
  class BasicObject
    instance_methods.each do |m|
      undef_method m unless m =~ /^(__|object_id)/
    end

    def method_missing(*args)
      nil
    end
  end
end
