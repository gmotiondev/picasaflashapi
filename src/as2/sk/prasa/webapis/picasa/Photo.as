import sk.prasa.webapis.picasa.Album;
import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.Content;
import sk.prasa.webapis.picasa.Exif;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.KindType;
import sk.prasa.webapis.picasa.Media;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Photo extends Base
{
	public var content : Content;
	public var published : String;
	public var gphoto : GPhoto;
	public var media : Media;
	public var exif : Exif;
	public var album : Album;

	private var __summary : String;
	
	//TODO: Geo VO
	public function Photo(o : Object)
	{
		super(o);
		
		__summary = o.summary;
		content = new Content(o.content.attributes.type, o.content.attributes.src);
		published = o.published;
		
		gphoto = new GPhoto(o, KindType.PHOTO);
		media = new Media(o["media:group"]);
		exif = new Exif(o["exif:tags"]);
	}
	 
	public function get summary() : String
	{
		return (typeof __summary) == "string" ? __summary : "";
	}
	 
	public function set summary(v : String) : Void
	{
		__summary = v;
	}
	
	public function toString() : String
	{
		var tRes = [];
			tRes.push(" summary=", summary);
			tRes.push(", content=", content.toString());
			tRes.push(", published=", published);
			tRes.push(", gphoto=", gphoto.toString());
			tRes.push(", media=", media.toString());
			tRes.push(", exit=", exif.toString());
		return "[Photo " + tRes.join("") + "]";
	}
}
