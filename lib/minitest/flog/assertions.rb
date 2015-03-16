require "flog_cli"

module Minitest
  module Flog
    module Assertions
      DEFAULT_FLOG_OPTIONS   = { all: true, continue: true }
      DEFAULT_METHOD_OPTIONS = { score: 40.0, ratio: 1.0 }

      attr_accessor   :filtered, :dir, :threshold

      def assert_method_score(dir, options = {})
        options = DEFAULT_METHOD_OPTIONS.merge options
        self.dir = dir
        self.threshold = options[:score]

        scores = _flog_scores_for_directory(dir)
        self.filtered = scores.select { |method, score| score > options[:score] }

        score_count = scores.count.to_f.round(2)
        filtered_count = self.filtered.count.to_f.round(2)
        msg = options[:msg] || message(options[:score], options[:ratio],
                                       1.0 - (filtered_count / score_count))
        assert (filtered_count / score_count) <= (1.0 - options[:ratio]), msg
      end

      def _flog_scores_for_directory(dir)
        flog = flog_for(dir)
        scores = {}
        flog.each_by_score do |method, score, list|
          scores[method] = score
        end
        scores
      end

      private

      def flog_for(dir)
        hash = FlogCLI.expand_dirs_to_files(dir).hash

        unless flog = Minitest::Flog.flogs[hash]
          flog = FlogCLI.new DEFAULT_FLOG_OPTIONS
          result = flog.flog dir
          Minitest::Flog.flogs[hash] = flog
          self.flog = flog
        end
        flog
      end

      def message(score, expected_ratio, actual_ratio)
        expected_percent = sprintf("%.1f", expected_ratio * 100)
        actual_percent = sprintf("%.1f", actual_ratio * 100)
        "Expected #{ expected_percent }% of flogged methods to have " +
          "score < #{ score } (actual: #{ actual_percent }%)"
      end
    end
  end
end
