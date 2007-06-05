import com.bourre.log.PixlibStringifier;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class Picasa.objects.Exif
{
	public var fstop, make, model, distance, exposure, flash, focallength, iso, time;
	
	public function Exif(a:Object)
	{
		fstop 		= a["fstop"];
		make 		= a["make"];
		model 		= a["model"];
		distance 	= a["distance"];
		exposure 	= a["exposure"];
		flash 		= a["flash"];
		focallength = a["focallength"];
		iso 		= a["iso"];
		time 		= a["time"];
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}
