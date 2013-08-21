require 'test_helper'

class CheckerTest < Test::Unit::TestCase

  def default_options(margin_width = 15)
    { 
      top_margin: margin_width, 
      right_margin: margin_width, 
      bottom_margin: margin_width, 
      left_margin: margin_width 
    }
  end

  test "PDF as pages with clear margins tested as pages" do
    checker = PDF::Margins::Checker.new(pdf_path('clear-margins-pages.pdf'), default_options)
    assert_equal [], checker.issues
  end

  test "PDF as spreads with clear margins tested as spreads" do
    checker = PDF::Margins::Checker.new(pdf_path('clear-margins-spreads.pdf'), default_options.merge(spreads: true))
    assert_equal [], checker.issues
  end

  test "PDF as spreads with clear margins tested as pages" do
    checker = PDF::Margins::Checker.new(pdf_path('clear-margins-spreads.pdf'), default_options)
    assert_equal [
      PDF::Margins::Issue.new(1, :left),
      PDF::Margins::Issue.new(2, :right),
      PDF::Margins::Issue.new(3, :left),
      PDF::Margins::Issue.new(4, :right)
    ], checker.issues
  end

  test "PDF as pages with dirty left margin" do
    checker = PDF::Margins::Checker.new(pdf_path('left-margin-only.pdf'), default_options)
    assert_equal [
      PDF::Margins::Issue.new(1, :left)
    ], checker.issues
  end

  test "PDF as pages with dirty right margin" do
    checker = PDF::Margins::Checker.new(pdf_path('right-margin-only.pdf'), default_options)
    assert_equal [
      PDF::Margins::Issue.new(1, :right)
    ], checker.issues
  end

  test "PDF with dirty top margin as spreads" do
    checker = PDF::Margins::Checker.new(pdf_path('top-margin-only.pdf'), default_options.merge(spreads: true))
    assert_equal [
      PDF::Margins::Issue.new(1, :top),
      PDF::Margins::Issue.new(2, :top),
      PDF::Margins::Issue.new(3, :top),
      PDF::Margins::Issue.new(4, :top)
    ], checker.issues
  end

  test "PDF with dirty bottom margin as spreads" do
    checker = PDF::Margins::Checker.new(pdf_path('bottom-margin-only.pdf'), default_options.merge(spreads: true))
    assert_equal [
      PDF::Margins::Issue.new(1, :bottom),
      PDF::Margins::Issue.new(2, :bottom),
      PDF::Margins::Issue.new(3, :bottom),
      PDF::Margins::Issue.new(4, :bottom)
    ], checker.issues
  end

  test "PDF with dirty top margin as pages" do
    checker = PDF::Margins::Checker.new(pdf_path('top-margin-only.pdf'), default_options)
    assert_equal [
      PDF::Margins::Issue.new(1, :top),
      PDF::Margins::Issue.new(2, :top),
      PDF::Margins::Issue.new(3, :top),
      PDF::Margins::Issue.new(4, :top)
    ], checker.issues
  end

  test "PDF with dirty bottom margin as pages" do
    checker = PDF::Margins::Checker.new(pdf_path('bottom-margin-only.pdf'), default_options)
    assert_equal [
      PDF::Margins::Issue.new(1, :bottom),
      PDF::Margins::Issue.new(2, :bottom),
      PDF::Margins::Issue.new(3, :bottom),
      PDF::Margins::Issue.new(4, :bottom)
    ], checker.issues
  end

  test "PDF with all dirty margins being checked as pages with a margin width of 0" do
    checker = PDF::Margins::Checker.new(pdf_path('16-page-mini.pdf'), default_options(0))
    assert_equal [], checker.issues
  end

  test "PDF with all dirty margins being checked as spreads with a margin width of 0" do
    checker = PDF::Margins::Checker.new(pdf_path('16-page-mini.pdf'), default_options(0).merge(spreads: true))
    assert_equal [], checker.issues
  end

  test "shelling out to mudraw fails" do
    checker = PDF::Margins::Checker.new(pdf_path('bottom-margin-only.pdf'), default_options)
    checker.expects(:system).returns(false)
    assert_raises(PDF::Margins::MuDrawCommandError) { checker.issues }
  end

end
