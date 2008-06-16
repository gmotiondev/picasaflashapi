package sk.prasa.webapis.picasa.objects 
{		
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Exif 
	{
		public var distance : Number; 		// exif:distance
		public var exposure : Number; 		// exif:exposure
		public var flash : Boolean;			// exif:flash
		public var focallength : Number; 	// exif:focallength
		public var fstop : Number;			// exif:fstop
		public var imageUniqueID : String;	// exif:imageUniqueID
		public var iso : Number;			// exif:iso
		public var make : String;			// exif:make
		public var model : String;			// exif:model
		public var time : Number;			// exif:time
		
		public function toString() : String
		{
			return "[Exif " +
				" distance=" + distance +
				", exposure=" + exposure +
				", flash=" + flash +
				", focallength=" + focallength +
				", fstop=" + fstop +
				", imageUniqueID=" + imageUniqueID +
				", iso=" + iso +
				", make=" + make +
				", model=" + model +
				", time=" + time +
				"]";
		}
	}
}
