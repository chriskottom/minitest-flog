module Minitest
  module Flog
    class Test < ::Minitest::Test
      include Assertions

      attr_accessor  :flog

      def self.runnable_methods
        methods_matching(/^flog_/)
      end

      def detail_report
        path = File.expand_path(self.dir)
        result = "\n  #{ path }:\n"
        flog.each_by_score do |method, score, list|
          break if score < self.threshold
          result << sprintf("  %8.1f  %s\n", score, method)
        end
        result
      end
    end
  end
end
