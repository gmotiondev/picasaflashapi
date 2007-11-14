/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.Exif
{
	public var distance:Number; 	// exif:distance
	public var exposure:Number; 	// exif:exposure
	public var flash:Boolean;		// exif:flash
	public var focallength:Number; 	// exif:focallength
	public var fstop:Number;		// exif:fstop
	public var imageUniqueID:String;// exif:imageUniqueID
	public var iso:Number;			// exif:iso
	public var make:String;			// exif:make
	public var model:String;		// exif:model
	public var time:Number;			// exif:time
	
	public function Exif(o:Object)
	{
		distance 	= o["exif:distance"];
		exposure 	= o["exif:exposure"];
		flash 		= o["exif:flash"];
		focallength = o["exif:focallength"];
		fstop 		= o["exif:fstop"];
		imageUniqueID = o["exif:imageUniqueID"];
		iso 		= o["exif:iso"];
		make 		= o["exif:make"];
		model 		= o["exif:model"];
		time 		= o["exif:time"];
	}
}