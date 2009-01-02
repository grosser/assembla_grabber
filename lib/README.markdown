Problem
=======
Assembla wants me to pay for my wiki/svn/...

Solution
========
Grab all the wiki contents so that i can enter them somewhere else.
Store name, human_name (how it was linked), text in markup form.

Usage
=====

    cp config.example.yml config.yml
    #enter your credentials

    rake init  #setup database
    rake grab_all
    rake grab PAGE=/wiki/show/MyRepo/PageName

    irb
    require 'init'
    Page.count

WARNING
=======
Grabbing is illegal, so your account may get closed or something else...
Therefore this libary is of course only for 'educational' purpose.

AUTHOR
======
Michael Grosser
grosser.michael@gmail.com
Hereby placed under public domain, do what you want, just do not hold me accountable...