package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaError extends Error
	{
		public static const ABSTRACT_METHOD_ERROR : String = "Abstract method, subclass should implement this method.";
		public static const NOT_IMPLEMENTED_ERROR : String = "Not yet implemented.";
		
		public function PicasaError(message : String)
		{
			super(message);
		}
	}
}
