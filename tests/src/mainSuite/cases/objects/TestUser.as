package mainSuite.cases.objects
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.objects.User;
public class TestUser extends TestCase 
{	
	public static const URI : String = "http://picasaweb.google.com/thisispinkfu";
	public static const EMAIL : String = "michal.gron@gmail.com";	

	public function testName() : void
	{
		var tUser : User = new User();		
			tUser.name = "Pink-fu";
		
		assertNotNull("tUser.name is null", tUser.name);
		assertEquals("tUser.name == NAME", tUser.name, "Pink-fu");
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