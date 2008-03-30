/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.PicasaError extends Error
{
	public static var ABSTRACT_METHOD_ERROR : String = "Abstract method, subclass should implement this method";

	public function PicasaError(message : String)
	{
		super(message);
	}	
}