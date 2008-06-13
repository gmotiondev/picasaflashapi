package sk.prasa.webapis.picasa.core.feed.atom 
{
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class UserNode 
	{
		public var name : String;
		public var uri : String;
		public var email : String;
		
		public function UserNode(aName : String = null, aUri : String = null, aEmail : String = null)
		{
			name = aName;
			uri = aUri;
			email = aEmail;
		}
	}
}
