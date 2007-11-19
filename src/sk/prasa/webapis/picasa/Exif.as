/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class sk.prasa.webapis.picasa.Exif
{
	private var __distance:Number; 	// exif:distance
	private var __exposure:Number; 	// exif:exposure
	private var __flash:Boolean;		// exif:flash
	private var __focallength:Number; 	// exif:focallength
	private var __fstop:Number;		// exif:fstop
	private var __imageUniqueID:String;// exif:imageUniqueID
	private var __iso:Number;			// exif:iso
	private var __make:String;			// exif:make
	private var __model:String;		// exif:model
	private var __time:Number;			// exif:time

	public function Exif(o:Object)
	{
		__distance 		= parseFloat(o["exif:distance"]);
		__exposure 		= parseFloat(o["exif:exposure"]);
		__flash 		= o["exif:flash"] != "false";
		__focallength 	= parseFloat(o["exif:focallength"]);
		__fstop 		= parseFloat(o["exif:fstop"]);
		__imageUniqueID = o["exif:imageUniqueID"];
		__iso 			= parseFloat(o["exif:iso"]);
		__make 			= o["exif:make"];
		__model 		= o["exif:model"];
		__time 			= parseFloat(o["exif:time"]);
	}
	
	public function get distance():Number
	{
		return __distance;
	}
	
	public function set distance(v:Number):Void
	{
		__distance = v;
	}

	public function get exposure():Number
	{
		return __exposure;
	}
	
	public function set exposure(v:Number):Void
	{
		__exposure = v;
	}

	public function get flash():Boolean
	{
		return __flash;
	}
	
	public function set flash(v:Boolean):Void
	{
		__flash = v;
	}

	public function get focallength():Number
	{
		return __focallength;
	}
	
	public function set focallength(v:Number):Void
	{
		__focallength = v;
	}

	public function get fstop():Number
	{
		return __fstop;
	}
	
	public function set fstop(v:Number):Void
	{
		__fstop = v;
	}

	public function get imageUniqueID():String
	{
		return __imageUniqueID;
	}
	
	public function set imageUniqueID(v:String):Void
	{
		__imageUniqueID = v;
	}

	public function get iso():Number
	{
		return __iso;
	}
	
	public function set iso(v:Number):Void
	{
		__iso = v;
	}
	
	public function get make():String
	{
		return __make;
	}
	
	public function set make(v:String):Void
	{
		__make = v;
	}
	
	public function get model():String
	{
		return __model;
	}
	
	public function set model(v:String):Void
	{
		__model = v;
	}
	
	public function get time():Number
	{
		return __time;
	}
	
	public function set time(v:Number):Void
	{
		__time = v;
	}
	
	public function toString():String
	{
		var tRes = [];
			tRes.push(" distance=",distance);
			tRes.push(", exposure=",exposure);
			tRes.push(", flash=",flash);
			tRes.push(", focallength=",focallength);
			tRes.push(", fstop=",fstop);
			tRes.push(", imageUniqueID=",imageUniqueID);
			tRes.push(", iso=",iso);
			tRes.push(", make=",make);
			tRes.push(", model=",model);
			tRes.push(", time=",time);
			
		return "[Exif "+tRes.join("")+"]";
	}
}