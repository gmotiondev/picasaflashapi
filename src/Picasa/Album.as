import com.bourre.log.PixlibStringifier;

import Picasa.objects.Media;
import Picasa.objects.GPhoto;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class Picasa.Album
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