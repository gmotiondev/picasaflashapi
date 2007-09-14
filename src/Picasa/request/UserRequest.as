/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.request.BasicRequest;

/**
 *
 */
class Picasa.request.UserRequest extends BasicRequest
{
	
	public function UserRequest(aFeed:String, aGetParams:Object)
	{
		super(aFeed, "album", aGetParams);
	}
	public function getRequest():String
	{
		//TODO: ADD GET PARAMS
		return getFeed();
	}
}