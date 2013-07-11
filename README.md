pdf/margins
==

[![Build
Status](https://travis-ci.org/newspaperclub/pdf_margins.png)](https://travis-ci.org/newspaperclub/pdf_margins)

Simple Ruby library to check a PDF for clear margin areas, by rendering to
a CMYK bitmap, ensuring that the pixel area defined by each margin is empty.
It's pretty slow, but this is a lot easier than attempting to work out which
object in a PDF is rendering into the margin area.

Depends on RMagick, and thus requires a Ruby interpreter that supports
C extensions, such as MRI.

Written by [Tom Taylor](http://scraplab.net), [Newspaper Club](http://www.newspaperclub.com).

Example
--

    # measurements in mm, ordered top, right, bottom, left (same as CSS)
    checker = PDF::Margins::Checker.new('example.pdf', 10, 10, 10, 10)
    puts checker.issues.inspect
