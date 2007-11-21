/**
 *
 */
import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.KindType;

class sk.prasa.webapis.picasa.Comment extends Base
{
	private var __published:String;
	private var __summary:String;
	private var __content:String;
	private var __gphoto:GPhoto;
	
	public function Comment(o:Object)
	{
		super(o);
		
		__published = o.published;
		__summary = o.summary;
		__content = o.content;
		__gphoto = new GPhoto(o, KindType.COMMENT);
	}
	
	public function get published():String
	{
		return __published;
	}
	
	public function set published(v:String):Void
	{
		__published = v;
	}
	
	public function get summary():String
	{
		return __summary;
	}
	
	public function set summary(v:String):Void
	{
		__summary = v;
	}
	
	public function get content():String
	{
		return __content;
	}
	
	public function set content(v:String):Void
	{
		__content = v;
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
		return "[Comment "+super.toString()+", published="+published+", summary="+summary+", content="+content+", gphoto="+gphoto.toString()+"]";
	}
}
/*
<entry>
  <id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5094406297232552993/photoid/5094407740341564914/commentid/5135197597808098660</id> 
  <published>2007-11-21T07:49:21.000Z</published> 
  <updated>2007-11-21T07:49:21.000Z</updated> 
  <category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#comment" /> 
  <title type="text">Pink-fu</title> 
  <summary type="text">Trenčín streetart :)..</summary> 
  <content type="text">Trenčín streetart :)..</content> 
  <link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/SampleAlbum/photo#5094407740341564914" /> 
  <link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5094406297232552993/photoid/5094407740341564914/commentid/5135197597808098660" /> 
- <author>
  <name>Pink-fu</name> 
  <uri>http://picasaweb.google.com/thisispinkfu</uri> 
  <gphoto:user>thisispinkfu</gphoto:user> 
  <gphoto:nickname>Pink-fu</gphoto:nickname> 
  <gphoto:thumbnail>http://lh6.google.com/thisispinkfu/AAAAY-cVBS8/AAAAAAAAAAA/CRZkCWt3d5Y/s48-c/thisispinkfu</gphoto:thumbnail> 
  </author>
  <gphoto:id>5135197597808098660</gphoto:id> 
  <gphoto:albumid>0</gphoto:albumid> 
  <gphoto:photoid>5094407740341564914</gphoto:photoid> 
  </entry>
- <entry>
*/