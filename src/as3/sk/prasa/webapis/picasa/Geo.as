package sk.prasa.webapis.picasa 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	public class Geo 
	{
		public var latitude : String;
		public var longitude : String;
		
		private namespace georss = "http://www.georss.org/georss";
		private namespace gml = "http://www.opengis.net/gml";
		
		//TODO: Test this please!
		public function Geo(item : XML)
		{
			try
			{
				var tGeoArray : Array = item.georss::where.gml::Point.gml::pos.split(" ");
				
				latitude = tGeoArray[0];
				longitude = tGeoArray[1];
			} catch(e : Error)
			{
				//if album/photo doesn't contains any geo info
			}
		}
		
		public function toString() : String
		{
			return "[Geo latitude=" + latitude + " longitude=" + longitude + "]";
		}
	}
}

/*
<georss:where>
	<gml:Point>
		<gml:pos>48.669025999999995 19.699023999999998</gml:pos>
	</gml:Point>
</georss:where>
*/