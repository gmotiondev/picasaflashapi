/**
 * @author Michal Gron
 */
 
 /*
 	<exif:tags>
		<exif:fstop>2.8</exif:fstop>
		<exif:make>Canon</exif:make>
		<exif:model>Canon PowerShot A410</exif:model>
		<exif:distance>0.0</exif:distance>
		<exif:exposure>0.05</exif:exposure>
		<exif:flash>false</exif:flash>
		<exif:focallength>5.4</exif:focallength>
		<exif:iso>0</exif:iso>
		<exif:time>1111641798000</exif:time>
	</exif:tags>
 */
 
class com.kvenda.services.objects.Exif
{
	public var fstop, make, model, distance, exposure, flash, focallength, iso, time;
	
	public function PicasaExifObject(a:Object)
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
