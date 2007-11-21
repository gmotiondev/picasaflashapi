/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.KindType;
import sk.prasa.webapis.picasa.GPhoto;

class sk.prasa.webapis.picasa.Tag extends Base
{
	private var __summary:String;
	private var __gphoto:GPhoto;
	
	public function Tag(o:Object)
	{
		super(o);
		
		__summary = o.summary;
		__gphoto = new GPhoto(o, KindType.TAG);
	}
	
	public function get summary():String
	{
		return __summary;
	}
	
	public function set summary(v:String):Void
	{
		__summary = v;
	}
	
	public function get gphoto():GPhoto
	{
		return __gphoto;
	}
	
	public function set gphoto(v:GPhoto):Void
	{
		__gphoto = v;
	}
	
	public function toString():String
	{
		return "[Tag "+super.toString()+", summary="+summary+", gphoto="+gphoto.toString()+"]";
	}
}

/* 
<entry>
  <id>http://picasaweb.google.com/data/entry/api/user/picasaflashapi/tag/even</id> 
  <updated>1970-01-01T00:01:24.000Z</updated> 
  <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#tag" /> 
  <title type="text">even</title> 
  <summary type="text">even</summary> 
  <link rel="alternate" type="text/html" href="http://picasaweb.google.com/lh/searchbrowse?q=even&psc=G&uname=picasaflashapi&filter=0" /> 
  <link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/picasaflashapi/tag/even" /> 
- <author>
  <name>Zuzana</name> 
  <uri>http://picasaweb.google.com/picasaflashapi</uri> 
  </author>
  <gphoto:weight>5</gphoto:weight> 
</entry>

*/