package mainSuite.cases.objects
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.objects.Content;
public class TestContent extends TestCase 
{
	private const SRC : String = "http://lh4.ggpht.com/thisispinkfu/RUSAQVVSABI/AAAAAAAAAAc/sWHyELe7z0M/Untitled-2.jpg";
	private const TYPE : String = "image/jpeg";
	private const VALUE : String = "this is sample content, but the type should be text!";	

	public function testSrc() : void
	{
		var tContent : Content = new Content();		
			tContent.src = SRC;
		
		assertNotNull("tContent.src is null", tContent.src);
		assertTrue("tContent.src == SRC", tContent.src == SRC);
	}
	
	public function testType() : void
	{
		var tContent : Content = new Content(TYPE);
			
		assertNotNull("tContent.type is null", tContent.type);
		assertTrue("tContent.type == TYPE", tContent.type == TYPE);
	}
	
	public function testValue() : void
	{
		var tContent : Content = new Content();
			tContent.value = VALUE;
			
		assertNotNull("tContent.value is null", tContent.value);
		assertTrue("tContent.value == VALUE", tContent.value == VALUE);
	}
}
}