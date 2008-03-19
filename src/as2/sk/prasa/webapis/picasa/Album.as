import sk.prasa.webapis.picasa.Base;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.Media;
import sk.prasa.webapis.picasa.Geo;
import sk.prasa.webapis.picasa.KindType;
import sk.prasa.webapis.picasa.User;
import sk.prasa.webapis.picasa.OpenSearch;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Album extends Base
{
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
}
