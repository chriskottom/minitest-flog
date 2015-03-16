require "minitest"

module Minitest
  module Flog
    class Reporter < Minitest::Reporter
      attr_accessor  :failed_flogs

      def initialize(io = $stdout, options = {})
        super
        self.failed_flogs = []
      end

      def record(result)
        if result.is_a?(Minitest::Flog::Test) && result.failure
          self.failed_flogs << result
        end
      end

      def report
        return unless self.options[:flog] && self.failed_flogs.any?

        result = "\nFlog reporting"
        failed_flogs.each do |f|
          result << f.detail_report
        end
        self.io.print result
      end
    end
  end
end
