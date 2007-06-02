import com.bourre.log.PixlibStringifier;

import com.kvenda.services.objects.Media;
import com.kvenda.services.objects.GPhoto;

/**
 * @author Michal Gron
 */
 
 
 /*
  <entry>
		<id>http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5046158866819398449</id>
		<published>2007-03-26T07:00:00.000Z</published>
		<updated>2007-03-26T09:17:05.000Z</updated>
		<category scheme="http://schemas.google.com/g/2005#kind" term="http://schemas.google.com/photos/2007#album"/>
		<title type="text">Unsorted Lomo</title>
		<summary type="text">Unsorted lomos</summary>
		<rights type="text">public</rights>
		<link rel="http://schemas.google.com/g/2005#feed" type="application/atom+xml" href="http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5046158866819398449"/>
		<link rel="alternate" type="text/html" href="http://picasaweb.google.com/thisispinkfu/UnsortedLomo"/>
		<link rel="self" type="application/atom+xml" href="http://picasaweb.google.com/data/entry/api/user/thisispinkfu/albumid/5046158866819398449"/>
		<author>
			<name>Pink-fu</name>
			<uri>http://picasaweb.google.com/thisispinkfu</uri>
		</author>
		<gphoto:id>5046158866819398449</gphoto:id>
		<gphoto:name>UnsortedLomo</gphoto:name>
		<gphoto:location>Various</gphoto:location>
		<gphoto:access>public</gphoto:access>
		<gphoto:timestamp>1174892400000</gphoto:timestamp>
		<gphoto:numphotos>12</gphoto:numphotos>
		<gphoto:user>thisispinkfu</gphoto:user>
		<gphoto:nickname>Pink-fu</gphoto:nickname>
		<gphoto:commentingEnabled>true</gphoto:commentingEnabled>
		<gphoto:commentCount>0</gphoto:commentCount>
		<media:group>
			<media:title type="plain">Unsorted Lomo</media:title>
			<media:description type="plain">Unsorted lomos</media:description>
			<media:keywords/>
			<media:content url="http://lh4.google.com/image/thisispinkfu/RgeOwPD1OzE/AAAAAAAAAK0/Fv8N5zvnUHY/UnsortedLomo.jpg" type="image/jpeg" medium="image"/>
			<media:thumbnail url="http://lh4.google.com/image/thisispinkfu/RgeOwPD1OzE/AAAAAAAAAK0/Fv8N5zvnUHY/UnsortedLomo.jpg?imgmax=160&crop=1" height="160" width="160"/>
			<media:credit>Pink-fu</media:credit>
		</media:group>
  </entry>  */
class com.kvenda.services.Album
{
	private var __d:Object;
	private var __g:GPhoto;
	private var __m:Media;
	
	//public var id:String;
	
	public function Album(a:Object)
	{
		__d = a;
		initialize();
	}
	
	private function initialize()
	{
		__g = new GPhoto({
			id 					: __d["gphoto:id"],
			name 				: __d["gphoto:name"],
			location 			: __d["gphoto:location"],
			access 				: __d["gphoto:access"],
			timestamp 			: __d["gphoto:timestamp"],
			numphotos 			: __d["gphoto:numphotos"],
			user 				: __d["gphoto:user"],
			nickname 			: __d["gphoto:nickname"],
			commentingEnabled 	: __d["gphoto:commentingEnabled"],
			commentCount 		: __d["gphoto:commentCount"]
		});
		
		__m = new Media(__d["media:group"]);
	}	
	public function getId():String
	{
		return __d["id"];
	}
	public function getThumbnailLink():String
	{
		return __m.thumbnail.url;
	}
	public function getIdString():String
	{
		return __g.id;
	}
	public function getPublished():String
	{
		return __d["published"];
	}
	public function getUpdated():String
	{
		return __d["updated"];
	}
	public function getTitle():String
	{
		return __d["title"];
	}
	public function getSummary():String
	{
		return __d["summary"];
	}
	public function getAuthorName():String
	{
		return __d["author"]["name"];
	}
	public function getAuthorUri():String
	{
		return __d["author"]["uri"];
	}
	public function getLink():String
	{
		return __d["link"][0].attributes.href;
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}