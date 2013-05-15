require 'test_helper'

class CheckerTest < Test::Unit::TestCase

  test "PDF with clear margins" do
    checker = PDF::Margins::Checker.new(pdf_path('clear-margins.pdf'), 10, 10, 10, 10)
    assert_equal [], checker.issues
  end

  test "PDF with dirty left margin on page 1" do
    checker = PDF::Margins::Checker.new(pdf_path('left-margin-only.pdf'), 10, 10, 10, 10)
    assert_equal [], checker.issues
  end

  test "PDF with dirty left margin on page 2" do
    checker = PDF::Margins::Checker.new(pdf_path('p2-left-margin-only.pdf'), 10, 10, 10, 10)
    assert_equal [PDF::Margins::Issue.new(2, :left)], checker.issues
  end

  test "PDF with dirty right margin on page 1" do
    checker = PDF::Margins::Checker.new(pdf_path('right-margin-only.pdf'), 10, 10, 10, 10)
    assert_equal [PDF::Margins::Issue.new(1, :right)], checker.issues
  end

  test "PDF with dirty top margin on page 1" do
    checker = PDF::Margins::Checker.new(pdf_path('top-margin-only.pdf'), 10, 10, 10, 10)
    assert_equal [PDF::Margins::Issue.new(1, :top)], checker.issues
  end

  test "PDF with dirty bottom margin on page 1" do
    checker = PDF::Margins::Checker.new(pdf_path('bottom-margin-only.pdf'), 10, 10, 10, 10)
    assert_equal [PDF::Margins::Issue.new(1, :bottom)], checker.issues
  end

end
