package mainSuite.cases.objects
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.objects.Category;
public class TestCategory extends TestCase 
{
	private const TERM : String = "http://schemas.google.com/photos/2007#user";
	private const SCHEME : String = "http://schemas.google.com/g/2005#kind";
	private const LABEL : String = null;

	public function testTerm() : void
	{
		var tCategory : Category = new Category();
			tCategory.term = TERM;
		
		assertNotNull("tCategory.term is null", tCategory.term);
		assertTrue("tCategory.term == TERM", tCategory.term == TERM);
	}

	public function testScheme() : void
	{
		var tCategory : Category = new Category();	
			tCategory.scheme = SCHEME;
		
		assertNotNull("tCategory.scheme is null", tCategory.scheme);
		assertTrue("tCategory.scheme == SCHEME", tCategory.scheme == SCHEME);
	}

	public function testLabel() : void
	{
		var tCategory : Category = new Category();
			tCategory.label = LABEL;
		
		assertNull("tCategory.label is not null", tCategory.label);
		assertTrue("tCategory.label == LABEL", tCategory.label == LABEL);
	}
}
}