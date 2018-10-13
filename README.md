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

Clone or update the submodule using

    git submodule update --init --recursive   # If first time
    git submodule update --recursive --remote # Otherwise

then

    bash misc/imgfetch.sh
    make
