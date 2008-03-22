package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class PicasaError extends Error
	{
		public static const ABSTRACT_METHOD_ERROR : String = "Abstract method, subclass should implement this method";
		public static const PARSING_FEED_ERROR : String = "Unable to parse requested feed.";
		public static const IO_ERROR : String = "Loading feed failed.";
		public static const SECURITY_ERROR : String = "Security violation error.";
		
		public function PicasaError(message : String)
		{
			super(message);
		}
	}
}
