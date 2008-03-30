import sk.prasa.webapis.picasa.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class sk.prasa.webapis.picasa.User extends BasicFeed
{
	public var opensearch : OpenSearch;
	public var gphoto : GPhoto;
	
	public function User(item : Object)
	{
		super(item, null);
		
		opensearch = new OpenSearch(item);
		gphoto = new GPhoto(item, KindType.USER);
	}
	
	public function toString() : String
	{
		return "[User " + super.toString() +
			", opensearch=" + opensearch.toString() +
			", gphoto=" + gphoto.toString() +
			"]";
	}
}
