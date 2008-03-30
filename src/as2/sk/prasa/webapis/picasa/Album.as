import sk.prasa.webapis.picasa.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Album extends BasicFeed
{
	/* implement also BasicFeed properties */
	public var content : Content;
	public var published : String;
	public var summary : String;
	
	/* and custom properties */
	public var gphoto : GPhoto;
	public var media : Media;
	public var geo : Geo;
	public var opensearch : OpenSearch;
	
	public function Album(aItem : Object, aParent : Object)
	{	
		super(aItem, aParent);
		
		content = new Content(aItem.content.attributes.type, aItem.content.attributes.src);
		published = aItem.published;
		summary = aItem.summary;
		
		gphoto = new GPhoto(aItem, KindType.ALBUM);
		media = new Media(aItem["media:group"]);
		geo = new Geo(aItem);
		opensearch = new OpenSearch(aItem);
	}

	public function toString() : String
	{
		return "[Album " + super.toString() +
			", content=" + content.toString() +
			", published=" + published + 
			", summary=" + summary +
			", gphoto=" + gphoto.toString() +
			", media=" + media.toString() +
			", geo=" + geo.toString() +
			", opensearch=" + opensearch.toString() +
			"]"; 
	}

	/*
	public var user : User;
	public var media : Media;
	public var gphoto : GPhoto;
	public var geo : Geo;
	public var opensearch : OpenSearch;
	
	public function Album(o : Object)
	{
		super(o);
		
		gphoto = new GPhoto(o, KindType.ALBUM);
		media = new Media(o["media:group"]);
		geo = new Geo(o);
		opensearch = new OpenSearch(o);
	}
	
	public function toString() : String
	{
		return "[Album gphoto=" + gphoto.toString() + ", media=" + media.toString() + ", geo=" + geo.toString() + ", opensearch=" + opensearch.toString() + "]";
	} 
	 */
}
