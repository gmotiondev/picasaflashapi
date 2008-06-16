package sk.prasa.webapis.picasa.objects 
{	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class Geo 
	{
		public var latitude : String;
		public var longitude : String;

		public function Geo(lat : String = null, lon : String = null)
		{
			latitude = lat;
			longitude = lon;
		}
		
		public function toString() : String
		{
			return "[Geo " +
				" latitude=" + latitude + 
				", longitude=" + longitude + 
				"]";
		}
	}
}
