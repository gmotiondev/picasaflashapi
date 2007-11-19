/**
 * Deprecated, will be deleted
 */
 /**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.request.BasicRequest;
import Picasa.request.RequestList;
import Picasa.request.IRequest;

class Picasa.request.UserRequest extends BasicRequest implements IRequest 
{
	// 
	public function UserRequest(aFeed:String, aGetParams:Object)
	{
		super(aFeed, RequestList.USER_REQUEST, aGetParams);
	}
	
	// 
	public function getRequest():String
	{
		// http://picasaweb.google.com/data/feed/api/user/thisispinkfu?kind=album&thumbsize=72&imgmax=720
		return getFeed()+"?kind="+getRequestType()+""+getParams();
	}
}