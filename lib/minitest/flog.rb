require "minitest/flog/assertions"
require "minitest/flog/reporter"
require "minitest/flog/test"
require "minitest/flog/version"

module Minitest
  module Flog
    def self.flogs
      @flogs ||= {}
    end
  end
end
