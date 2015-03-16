require "minitest"
require "flog"

module Minitest
  def self.plugin_flog_options(opts, options)
    opts.on "-f", "--flog", "Display a detailed Flog report output" do |f|
      options[:flog] = true
    end
  end

  def self.plugin_flog_init(options)
    if options[:flog]
      self.reporter << Minitest::Flog::Reporter.new(options[:io], options)
    end
  end
end
