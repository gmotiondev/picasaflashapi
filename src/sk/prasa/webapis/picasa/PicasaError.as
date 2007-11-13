/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.PicasaError
{
	/** The login details or auth token passed were invalid. */
	public static var LOGIN_FAILED:Number = 98;
	
	/** The method requires user authentication but the user was not logged in, or the authenticated method call did not have the required permissions. */
	public static var INSUFFICIENT_PERMISSIONS:Number = 99;	
	
	/** The API key passed was not valid or has expired. */
	public static var INVALID_API_KEY:Number = 	100;
	
	/** The requested service is temporarily unavailable. */
	public static var SERVICE_CURRENTLY_UNAVAILABLE:Number = 105;
	
	/** The requested response format was not found. */
	public static var FORMAT_NOT_FOUND:Number = 111;
	
	/** The requested method was not found. */
	public static var METHOD_NOT_FOUND:Number = 112;

	/** The XML-RPC request document could not be parsed */
	public static var INVALID_XML_RPC_CALL:Number = 115;
	
	private var __code:Number;
	private var __message:String;
	
	public function PicasaError()
	{
	}
	
	public function get code():Number
	{
		return __code;	
	}
	
	public function set code(value:Number):Void
	{
		__code = value;	
	}

	public function get message():String
	{
		return __message;	
	}
	
	public function set message(value:String):Void
	{
		__message = value;	
	}
}