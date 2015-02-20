module Comptaline
  class Utils
    def self.convert_to_match_id(integer)
      integer % 1000000000
    end
  end
end