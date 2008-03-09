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
		return "[Geo latitude=" + latitude + " longitude=" + longitude + "]";
	}
}
/*
<georss:where>
- <gml:Point>
  <gml:pos>51.235976 0.732298</gml:pos> 
  </gml:Point>
  </georss:where>
  
   1. georss:where
   2. gml:Point
   3. gml:pos
*/