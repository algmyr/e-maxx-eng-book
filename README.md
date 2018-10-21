e-maxx-eng algorithms book
==========================

Scripts to build the articles in the https://github.com/e-maxx-eng/e-maxx-eng project into book form. A (hopefully up to date) preview can be found at: http://web.student.chalmers.se/~algmyr/upload/e-maxx.pdf

Prerequisites
-------------

* some LaTeX distribution
* pandoc
* perl
* bash
* grep, sed, ...
* wget
* make

Build process
-------------

Clone or update the submodule using

    git submodule update --init --recursive   # If first time
    git submodule update --recursive --remote # Otherwise

then

    bash misc/imgfetch.sh
    make

Page layout
-----------

Two layouts are available for easy use: `oneside` and `twoside`. Switch between the two by editing the first line of `template.tex`.

### oneside
The default and is a good fit for on-screen reading.

* no extra blank pages
* symmetric margins
* headers have page numbering on the right side

### twoside
A good fit for books.

* blank pages are added to make parts and chapters start on even pages
* margins are non-symmetric for a nicer experience with an open book (slimmer inner margins)
* headers have page numbering on the outside
