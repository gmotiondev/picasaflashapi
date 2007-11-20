/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.KindType;
 
class sk.prasa.webapis.picasa.User extends Base
{
	// TODO:
	//private var __opensearch:OpenSearch;
	private var __gphoto:GPhoto;
	
	public function User(o:Object)
	{
		super(o);
		
		__gphoto = new GPhoto(o, KindType.USER);
	}
	
	public function get gphoto():GPhoto
	{
		return __gphoto;
	}
	
	public function set gphoto(g:GPhoto):Void
	{
		__gphoto = g;
	}
	
	public function toString():String
	{
		return "[User "+super.toString()+", gphoto="+gphoto.toString()+"]";
	}
}

/*
<feed xmlns="http://www.w3.org/2005/Atom" xmlns:openSearch="http://a9.com/-/spec/opensearchrss/1.0/" xmlns:geo="http://www.w3.org/2003/01/geo/wgs84_pos#" xmlns:gml="http://www.opengis.net/gml" xmlns:georss="http://www.georss.org/georss" xmlns:photo="http://www.pheed.com/pheed/" xmlns:media="http://search.yahoo.com/mrss/" xmlns:batch="http://schemas.google.com/gdata/batch" xmlns:gphoto="http://schemas.google.com/photos/2007">
  <id>http://picasaweb.google.com/data/feed/api/user/picasaflashapi</id> 
  <updated>2007-11-20T13:30:33.672Z</updated> 
  <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#user" /> 
  <title type="text">picasaflashapi</title> 
  <subtitle type="text" /> 
  <icon>http://lh4.google.com/picasaflashapi/AAAA84DinGg/AAAAAAAAAAA/Jf6d_1GKC_k/s64-c/picasaflashapi</icon> 
  <link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/picasaflashapi" /> 
  <link rel="alternate" type="text/html" href="http://picasaweb.google.com/picasaflashapi" /> 
  <link rel="http://schemas.google.com/photos/2007#slideshow" type="application/x-shockwave-flash" href="http://picasaweb.google.com/s/c/bin/slideshow.swf?host=picasaweb.google.com&RGB=0x000000&feed=http%3A%2F%2Fpicasaweb.google.com%2Fdata%2Ffeed%2Fapi%2Fuser%2Fpicasaflashapi%3Falt%3Drss" /> 
  <link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/picasaflashapi?start-index=1&max-results=1000&kind=album" /> 
- <author>
  <name>Zuzana</name> 
  <uri>http://picasaweb.google.com/picasaflashapi</uri> 
  </author>
  <generator version="1.00" uri="http://picasaweb.google.com/">Picasaweb</generator> 
  <openSearch:totalResults>1</openSearch:totalResults> 
  <openSearch:startIndex>1</openSearch:startIndex> 
  <openSearch:itemsPerPage>1000</openSearch:itemsPerPage> 
  <gphoto:user>picasaflashapi</gphoto:user> 
  <gphoto:nickname>Zuzana</gphoto:nickname> 
  <gphoto:thumbnail>http://lh4.google.com/picasaflashapi/AAAA84DinGg/AAAAAAAAAAA/Jf6d_1GKC_k/s64-c/picasaflashapi</gphoto:thumbnail> 
 */