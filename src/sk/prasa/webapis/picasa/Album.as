/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.Geo;
import sk.prasa.webapis.picasa.KindType;
import sk.prasa.webapis.picasa.User;

class sk.prasa.webapis.picasa.Album extends Base
{
	private var __user:User;
	private var __gphoto:GPhoto;
	private var __geo:Geo;
	// TODO: add open search VO
	//private var __opensearch:OpenSearch;
	
	public function Album(o:Object)
	{
		super(o);
		
		__gphoto = new GPhoto(o, KindType.ALBUM);
		__geo = new Geo(o);
	}
	
	public function get user():User
	{
		return __user;
	}
	
	public function set user(v:User):Void
	{
		__user = v;
	}
	
	public function get gphoto():GPhoto
	{
		return __gphoto;
	}
	
	public function set gphoto(g:GPhoto):Void
	{
		__gphoto = g;
	}
	
	public function get geo():Geo
	{
		return __geo;
	}
	
	public function set geo(g:Geo):Void
	{
		__geo = g;
	}
	
	public function toString():String
	{
		return "[Album gphoto="+gphoto.toString()+", geo="+geo.toString()+"]"
	}
}

/*
<id>http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993</id> 
  <updated>2007-08-03T09:52:22.000Z</updated> 
  <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#album" /> 
  <title type="text">Sample Album</title> 
  <subtitle type="text">This is sample album to feed up a Picasa Flash API content!</subtitle> 
  <rights type="text">public</rights> 
  <icon>http://lh6.google.com/thisispinkfu/RrL3iTgPNCE/AAAAAAAAAYI/ytQJLLFz3Hc/s160-c/SampleAlbum.jpg</icon> 
  <link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993" /> 
  <link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/SampleAlbum" /> 
  <link rel="http://schemas.google.com/photos/2007#slideshow" type="application/x-shockwave-flash" href="http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fthisispinkfu%2Falbumid%2F5094406297232552993%3Falt%3Drss" /> 
  <link rel="http://schemas.google.com/photos/2007#report" type="text/html" href="http://picasaweb.google.com/lh/reportAbuse?uname=thisispinkfu&aid=5094406297232552993" /> 
  <link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5094406297232552993?start-index=1&max-results=1000" /> 
- <author>
  <name>Pink-fu</name> 
  <uri>http://picasaweb.google.com/thisispinkfu</uri> 
  </author>
  <generator version="1.00" uri="http://picasaweb.google.com/">Picasaweb</generator> 
  <openSearch:totalResults>28</openSearch:totalResults> 
  <openSearch:startIndex>1</openSearch:startIndex> 
  <openSearch:itemsPerPage>1000</openSearch:itemsPerPage> 
  <gphoto:id>5094406297232552993</gphoto:id> 
  <gphoto:name>SampleAlbum</gphoto:name> 
  <gphoto:location>Worldwide</gphoto:location> 
  <gphoto:access>public</gphoto:access> 
  <gphoto:timestamp>1186124400000</gphoto:timestamp> 
  <gphoto:numphotos>28</gphoto:numphotos> 
  <gphoto:user>thisispinkfu</gphoto:user> 
  <gphoto:nickname>Pink-fu</gphoto:nickname> 
  <gphoto:commentingEnabled>true</gphoto:commentingEnabled> 
  <gphoto:commentCount>0</gphoto:commentCount> 
- <georss:where>
- <gml:Point>
  <gml:pos>51.235976 0.732298</gml:pos> 
  </gml:Point>
  </georss:where>
  */