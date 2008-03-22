package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
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
	
		private namespace exif = "http://schemas.google.com/photos/exif/2007";
		
		public function Exif(item : XML)
		{
			use namespace exif;
			
			distance 		= parseFloat(item.tags.distance);
			exposure 		= parseFloat(item.tags.exposure);
			flash 			= item.tags.flash != "false";
			focallength 	= parseFloat(item.tags.focallength);
			fstop 			= parseFloat(item.tags.fstop);
			imageUniqueID 	= item.tags.imageUniqueID;
			iso 			= parseFloat(item.tags.iso);
			make 			= item.tags.make;
			model 			= item.tags.model;
			time 			= parseFloat(item.tags.time);
		}
		
		public function toString() : String
		{
			var tRes : Array = [];
				tRes.push(" distance=", distance);
				tRes.push(", exposure=", exposure);
				tRes.push(", flash=", flash);
				tRes.push(", focallength=", focallength);
				tRes.push(", fstop=", fstop);
				tRes.push(", imageUniqueID=", imageUniqueID);
				tRes.push(", iso=", iso);
				tRes.push(", make=", make);
				tRes.push(", model=", model);
				tRes.push(", time=", time);
				
			return "[Exif " + tRes.join("") + "]";
		}
	}
}

/*
<exif:tags>
	<exif:imageUniqueID>9f621bc616845e7b03b235acad04d122</exif:imageUniqueID>
</exif:tags>
*/