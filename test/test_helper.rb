$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require "minitest/reporters"
require "rack/mock"

require_relative "blog/config/environment"

MiniTest::Reporters.use! [Minitest::Reporters::DefaultReporter.new]
