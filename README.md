e-maxx-eng algorithms book
==========================

Scripts to build the articles in the https://github.com/e-maxx-eng/ project into book form.

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

    git submodule update --recursive --remote
    bash misc/imgfetch.sh
    make
