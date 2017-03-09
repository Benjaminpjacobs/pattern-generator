
require "minitest/autorun"
require "minitest/pride"
require_relative 'pattern_generator.rb'

class PatternGeneratorTest < Minitest::Test
  def test_it_exists
    pg = PatternGenerator.new
  end

  def test_verify_pattern
    pg = PatternGenerator.new
    pattern = ".#."
    assert pg.verify("A3B", pattern)
    refute pg.verify("AAB", pattern)
  end

  def test_verify_longer_pattern_with_literal
    pg = PatternGenerator.new
    pattern = ".#.2#..cF."
    assert pg.verify("A3B24CDcFG", pattern)
    refute pg.verify("A3B24CDcFg", pattern)
  end

  def test_it_can_total_avail_pattern
    pg = PatternGenerator.new
    pattern = ".#."
    assert_equal 6760, pg.total_available(pattern)
  end

  def test_it_can_total_avail_pattern_with_literals
    pg = PatternGenerator.new
    pattern = ".#.C..#17"
    assert_equal 45697600, pg.total_available(pattern)
  end

  def test_it_can_generate_pattern
    pg = PatternGenerator.new
    pattern = ".#."
    assert_equal "A0A", pg.generate(0, pattern)
    assert_equal "A1B", pg.generate(27, pattern)
  end

end