/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class sk.prasa.webapis.picasa.Geo
{
	public var latitude : String;
	public var longitude : String;
	
	public function Geo(o:Object)
	{
		var tGeoArray : Array = o["georss:where"]["gml:Point"]["gml:pos"].split(" ");
		
		latitude = tGeoArray[0];
		longitude = tGeoArray[1];
	}
	
	public function toString() : String
	{
		return "[Geo " +
			" latitude=" + latitude + 
			", longitude=" + longitude + 
			"]";
	}
}
