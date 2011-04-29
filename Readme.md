Wrapper for cotendo SOAP Api

Install
=======
    sudo gem install cotendo

Usage
=====
    client = Cotendo.new(:user => 'user', :password => 'password')

    # flush
    client.flush(cname, "/images/*") # hard flush
    client.flush(cname, ["/images/*", "/*.jsp", "/*.txt"], :flush_type => 'soft')

Author
======
[Michael Grosser](http://grosser.it)<br/>
michael@grosser.it<br/>
Hereby placed under public domain, do what you want, just do not hold me accountable...
