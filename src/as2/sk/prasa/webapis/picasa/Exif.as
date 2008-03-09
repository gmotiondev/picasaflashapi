/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Exif
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

	public function Exif(o:Object)
	{
		distance 		= parseFloat(o["exif:distance"]);
		exposure 		= parseFloat(o["exif:exposure"]);
		flash 			= o["exif:flash"] != "false";
		focallength 	= parseFloat(o["exif:focallength"]);
		fstop 			= parseFloat(o["exif:fstop"]);
		imageUniqueID 	= o["exif:imageUniqueID"];
		iso 			= parseFloat(o["exif:iso"]);
		make 			= o["exif:make"];
		model 			= o["exif:model"];
		time 			= parseFloat(o["exif:time"]);
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