package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class MediaThumbnail 
	{
		public var url : String;
		public var width : Number;
		public var height : Number;
		
		public function MediaThumbnail(u : String, w : Number, h : Number)
		{
			url = u;
			width = w;
			height = h;
		}
		
		public function toString() : String
		{
			return "[MediaThumbnail " +
				"url=" + url + 
				", width=" + width + 
				", height=" + height + 
				"]";
		}
	}
}