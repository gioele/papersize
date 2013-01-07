papersize
=========

A simple Ruby script that generates a PDF with markers for various paper sizes:

* A4, A5, A6,
* B5, B6,
* C5, C5.

Useful to test whether your printer is printing documents correctly and if a
PDF reader is displaying documents properly.


Usage
-----

First you need to make sure that all the dependencies are installed

    bundle install --path gems/

then you can launch the script

    bundle exec ./gen-papersize-pdf.rb

The script will generate a `papersize.pdf` file.

Now you can open it in your PDF reader and see whether it is displayed with
with the proper size or print it and see if your printer can print
dimensions-accurate PDFs.


Authors
-------

* Gioele Barabucci <http://svario.it/gioele>


Development
-----------

Code
: <https://github.com/gioele/papersize>

Report issues
: <https://github.com/gioele/papersize/issues>


License
-------

This is free software released into the public domain (CC0 license).

See the `COPYING` file or <http://creativecommons.org/publicdomain/zero/1.0/>
for more details.
