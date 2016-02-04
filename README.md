Realtime Support for Rails
====

Note: This gem is a concept piece originally conceived in 2013 and published as a generic open source project in early 2014. 

As of mid-2015, support for performant, native and scalable websockets are available in Rails. See ~~[ActiveCable](https://github.com/rails/actioncable)~~ [ActionCable](https://github.com/rails/rails/tree/master/actioncable), which landed in Rails 5 and will probably be officially released early/mid 2016. 

As such, with [`ActionCable`'s design](http://weblog.rubyonrails.org/2016/2/2/Rails-5-0-beta2/), you don't even need a separate pub/sub server (redis) and Node.js running anymore to achieve similar lightweight realtime bi-directional communication with a large number of connected clients to your Rails application. 

Progress marches forward! I presume, if you are stuck and can't upgrade to Rails 5 anytime soon, perhaps this project is lightweight compared to some of the heavier alternatives like Faye or PubNub.

Full documentation is available at:

http://mikeatlas.github.io/realtime-rails/
