# Flash Player and Google Accounts Authentication (FIXED) #

So what's the point? It's about Google Accounts authentication from Flash Player clients. This is ~~half~~ _working_.

Since we have AuthSub with correct crossdomain file and Picasa Web Data API has 

&lt;allow-http-request-headers-from domain="\*" headers="Authorization,X-HTTP-Method-Override"/&gt;

 , we can successfuly make authenticated requests to the Picasa Web Data API via Flash Player.

Try it out on simple example, by listing your private albums: http://www.prasa.sk/authsub

---

## "Working" half ##
Authentication from Flash Player "is working" when the client is wrapped inside Adobe AIR. AIR hasn't security restriction like Flash Player plugin, so it allows us authenticate users directly from AIR application. Authorization goes via Goolge Accounts ClientLogin method.

## "Not working" half ##
When you try to authenticate the user via Flash Player in browser, you use the Google Accounts AuthSub method. This is not working because when you obtain new token you are NOT able to send  http request with Authorization Header because of security restriction - Google has to put a crossdomain.xml file on their Google Accounts Site.

You can vote for this issue to be fixed here: http://code.google.com/p/gdata-issues/issues/detail?id=406

## Resumé ##
This issue makes the Picasa Flash API read-only. You CANNOT create albums, post photos, comments, etc.. - you CANNOT do the "write stuff". you CAN just read from Picasa Web Albums Data API - you CAN read only public albums, photos, comments, tags, search for community pictures etc..

I'm sorry about that and i hope this will be fixed at some time.