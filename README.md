pdf/margins
==

[![Build
Status](https://travis-ci.org/newspaperclub/pdf_margins.png)](https://travis-ci.org/newspaperclub/pdf_margins)

Simple Ruby library to check a PDF for clear margin areas, by rendering to
a bitmap, ensuring that the pixel area defined by each margin is empty. 

This is a bit of a clumsy technique, but it's faster than parsing and
understanding all the permutations of the PDF format that may result in an
object being visible in the margins.

It shells out to `mudraw`, part of [mupdf] [1], for rastering the PDF to PNGs,
and then uses [Chunky PNG] [2] to examine each page's margins.

On Ubuntu, you may wish to install `mupdf` from the [PPA] [3].

Written by [Tom Taylor] [3], [Newspaper Club] [4].

[1]: http://www.mupdf.com
[2]: https://github.com/wvanbergen/chunky_png
[3]: https://launchpad.net/~mupdf/+archive/stable
[4]: http://scraplab.net
[5]: http://www.newspaperclub.com

Example
--

    # accepts a `spreads` boolean which assumes margin dimensions refer to
    # spreads, and so alternates which pages we check left and right margins on
    spreads = true
    # measurements in mm, ordered top, right, bottom, left (same as CSS)
    checker = PDF::Margins::Checker.new('example.pdf', 10, 10, 10, 10, spreads)
    puts checker.issues.inspect
