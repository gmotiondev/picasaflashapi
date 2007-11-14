/**
 *
 */
class sk.prasa.webapis.picasa.Geo
{
	public var latitude:String;
	public var longitude:String;
	
	public function Geo(lat:String, lon:String)
	{
		latitude = lat;
		longitude = lon;
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