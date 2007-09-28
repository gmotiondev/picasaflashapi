/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import Picasa.objects.BasicObject;
 
class Picasa.objects.Exif extends BasicObject
{
	public var fstop, make, model, distance, exposure, flash, focallength, iso, time:String;
	
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
}
