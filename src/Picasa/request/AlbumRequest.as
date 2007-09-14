/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.request.BasicRequest;

/**
 *
 */
class Picasa.request.AlbumRequest extends BasicRequest
{
	private var __id:String;
	
	public function AlbumRequest(aFeed:String, aId:String, aGetParams:Object)
	{
		super(aFeed, "photo", aGetParams);
		__id = aId;
	}
	private function getId():String
	{
		return __id;
	}
	public function getRequest():String
	{
		//http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5071041246998165969?kind=photo&thumbsize=72&imgmax=720
		return getFeed()+"/albumid/"+getId()+"?kind="+getKind()+""+getParams();
	}
}