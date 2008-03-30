import sk.prasa.webapis.picasa.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Photo extends BasicFeed
{
	/* implement also BasicFeed properties */
	public var content : Content;
	public var published : String;
	//public var summary : String;
	private var __summary : String;

	/* and custom properties */
	public var exif : Exif;
	public var geo : Geo;
	public var gphoto : GPhoto;
	public var media : Media;
	
	public function Photo(aItem : Object, aParent : Object)
	{
		super(aItem, aParent);

		content = new Content(aItem.content.attributes.type, aItem.content.attributes.src);
		published = aItem.published;
		summary = aItem.summary;
		
		exif = new Exif(aItem["exif:tags"]);
		geo = new Geo(aItem);
		gphoto = new GPhoto(aItem, KindType.PHOTO);
		media = new Media(aItem["media:group"]);
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
		return "[Photo" + super.toString() +
			", content=" + content.toString() +
			", published=" + published + 
			", summary=" + summary +
			", exif=" + exif.toString() +
			", geo=" + geo.toString() +
			", gphoto=" + gphoto.toString() + 
			", media=" + media.toString() + 
			"]";
	}
	/*
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
	}*/
}
