/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.PicasaError
{
	public static var LOGIN_FAILED : String = "The login details or auth token passed were invalid.";
	public static var INSUFFICIENT_PERMISSIONS : String = "The method requires user authentication but the user was not logged in, or the authenticated method call did not have the required permissions.";
	public static var INVALID_API_KEY : String = "The API key passed was not valid or has expired.";
	public static var SERVICE_CURRENTLY_UNAVAILABLE : String = "The requested service is temporarily unavailable.";
	public static var FORMAT_NOT_FOUND : String = "The requested response format was not found.";
	public static var METHOD_NOT_FOUND : String = "The requested method was not found.";

	public var code : Number;
	public var message : String;
	
	public function PicasaError()
	{
	}	
}