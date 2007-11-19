/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.request.BasicRequest;
import Picasa.request.RequestList;
import Picasa.request.IRequest;

class Picasa.request.PhotoRequest extends BasicRequest implements IRequest
{
	private var __id:String;
	
	// 
	public function PhotoRequest(aFeed:String, aId:String, aGetParams:Object)
	{
		super(aFeed, RequestList.PHOTO_REQUEST, aGetParams);
		__id = aId;
	}
	
	// 
	private function getId():String
	{
		return __id;
	}
	
	// http://picasaweb.google.com/data/feed/api/user/thisispinkfu/albumid/5071041246998165969?kind=photo&thumbsize=72&imgmax=720
	public function getRequest():String
	{
		return getFeed()+"/albumid/"+getId()+"?kind="+getRequestType()+""+getParams();
	}
}

