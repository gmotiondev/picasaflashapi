package atom
{
	import sk.prasa.webapis.picasa.objects.User;	
	
	import flexunit.framework.TestCase;	

	public class UserTest extends TestCase 
	{	
		public static const NAME : String = "Pink-fu";
		public static const URI : String = "http://picasaweb.google.com/thisispinkfu";
		public static const EMAIL : String = "michal.gron@gmail.com";

		public function UserTest(methodName : String = null)
		{
			super(methodName);
		}			

		public function testName() : void
		{
			var tUser : User = new User();		
				tUser.name = NAME;
			
			assertNotNull("tUser.name is null", tUser.name);
			assertTrue("tUser.name == NAME", tUser.name == NAME);
		}

		public function testUri() : void
		{
			var tUser : User = new User();
				tUser.uri = URI;
			
			assertNotNull("tUser.uri is null", tUser.uri);
			assertTrue("tUser.uri == URI", tUser.uri == URI);
		}

		public function testEmail() : void
		{
			var tUser : User = new User();
				tUser.email = EMAIL;
			
			assertNotNull("tUser.email is null", tUser.email);
			assertTrue("tUser.email == EMAIL", tUser.email == EMAIL);
		}		
	}
}