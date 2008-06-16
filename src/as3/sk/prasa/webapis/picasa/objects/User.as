package sk.prasa.webapis.picasa.objects 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 * 
	 */
	public class User 
	{
		public var name : String;
		public var uri : String;
		public var email : String;
		
		public function User(aName : String = null, aUri : String = null, aEmail : String = null)
		{
			name = aName;
			uri = aUri;
			email = aEmail;
		}
		
		public function toString() : String
		{
			return "[User name=" + name + ", uri=" + uri + ", email=" + email + "]";
		}
	}
}
