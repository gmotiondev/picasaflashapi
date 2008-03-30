import sk.prasa.webapis.picasa.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Comment extends BasicEntry
{
	public var gphoto : GPhoto;
	//BUG?: GPHOTO IS IN THE AUTHOR FEED
	
	public function Comment(aItem : Object, aParent : Object)
	{
		super(aItem, aParent);
		
		gphoto = new GPhoto(aItem, KindType.COMMENT);
	}
	
	public function toString() : String
	{
		return "[Comment" + super.toString() +
			", gphoto=" + gphoto.toString() +
			"]";
	} 

	/*
	public var published : String;
	public var summary : String;
	public var content : String;
	public var gphoto : GPhoto;
	
	public function Comment(o:Object)
	{
		super(o);
		
		published = o.published;
		summary = o.summary;
		content = o.content;
		gphoto = new GPhoto(o, KindType.COMMENT);
	}
	
	public function toString() : String
	{
		return "[Comment " + super.toString() + ", published=" + published + ", summary=" + summary + ", content=" + content + ", gphoto=" + gphoto.toString() + "]";
	}*/
}
