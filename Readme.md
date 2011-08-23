Wrapper for cotendo SOAP Api

Install
=======
    sudo gem install cotendo

Usage
=====
    client = Cotendo.new(:user => 'user', :password => 'password')

    # flush
    client.flush('orig-10001.MyCompany.cotcdn.net', "/images/*") # hard flush
    client.flush('orig-10001.MyCompany.cotcdn.net', ["/images/*", "/*.jsp", "/*.txt"], :flush_type => 'soft')

TODO
====
 - add whole [API](http://help.cotendo.net/display/Manual30/APIs)

Author
======
### [Contributors](http://github.com/grosser/cotendo/contributors)
 - [Nicolas Fouché](http://about.me/nfo)

[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
Hereby placed under public domain, do what you want, just do not hold me accountable...
