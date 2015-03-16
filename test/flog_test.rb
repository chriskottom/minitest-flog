require 'test_helper'

class FlogTest < Minitest::Test
  def test_runnable_methods_correct
    test_flogger = Class.new Minitest::Flog::Test do
      def flog_this; end
      def flog_that; end
      def dont_flog_this; end
      private
      def flog_something_else; end
    end

    runnable_methods = test_flogger.runnable_methods.sort
    assert_equal %w(flog_that flog_this), runnable_methods
  end
end

class FlogAssertionsTest < Minitest::Test
  # With just a directory, the assert defaults to max score = 40, ratio = 1.0.
  def test_assert_method_score_just_directory
    flogger_class = Class.new Minitest::Flog::Test do
      def flog_this
        assert_method_score("some_dir")
      end
    end

    flogger = flogger_class.new(:flog_this)
    flogger.stub(:_flog_scores_for_directory, { "foo" => 40.0 }) do
      result = flogger.run
      assert result.passed?, "Expected the test to pass, but it didn't: #{ result.result_code }"
    end

    flogger.stub(:_flog_scores_for_directory, { "foo" => 40.1 }) do
      result = flogger.run
      failure = result.failure
      assert_instance_of Minitest::Assertion, failure

      msg = "Expected 100.0% of flogged methods to have score < 40.0 (actual: 0.0%)"
      assert_equal msg, failure.message
    end
  end

  def test_assert_method_score_with_score
    flogger_class = Class.new Minitest::Flog::Test do
      def flog_that
        assert_method_score("some_dir", score: 50.0)
      end
    end

    flogger = flogger_class.new(:flog_that)
    flogger.stub(:_flog_scores_for_directory, { "foo" => 50.0 }) do
      result = flogger.run
      assert result.passed?, "Expected the test to pass, but it didn't: #{ result.result_code }"
    end

    flogger.stub(:_flog_scores_for_directory, { "foo" => 50.1 }) do
      result = flogger.run
      failure = result.failure
      assert_instance_of Minitest::Assertion, failure

      msg = "Expected 100.0% of flogged methods to have score < 50.0 (actual: 0.0%)"
      assert_equal msg, failure.message
    end
  end

  def test_assert_method_score_with_score_and_ratio
    flogger_class = Class.new Minitest::Flog::Test do
      def flog_everything
        assert_method_score("some_dir", score: 50.0, ratio: 0.5)
      end
    end

    flogger = flogger_class.new(:flog_everything)
    flogger.stub(:_flog_scores_for_directory, { "foo" => 49.0, "bar" => 51.0 }) do
      result = flogger.run
      assert result.passed?, "Expected the test to pass, but it didn't: #{ result.result_code }"
    end

    flogger.stub(:_flog_scores_for_directory,
                 { "foo" => 50.1, "bar" => 51.0, "bat" => 49.0 }) do
      result = flogger.run
      failure = result.failure
      assert_instance_of Minitest::Assertion, failure

      msg = "Expected 50.0% of flogged methods to have score < 50.0 (actual: 33.3%)"
      assert_equal msg, failure.message
    end
  end
end
