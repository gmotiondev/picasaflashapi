package mainSuite.cases.objects
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.objects.Text;
public class TestText extends TestCase 
{
	private const TYPE : String = "text";
	private const VALUE : String = "thisispinkfu";
	
	public static const TYPE_TEXT : String = "text";
	public static const TYPE_HTML : String = "html";
	public static const TYPE_XHTML : String = "xhtml";
	public static const TYPE_PLAIN : String = "plain";
	
	public function testTYPE_PLAIN() : void
	{
		assertNotNull("TextTag.TYPE_PLAIN is null", Text.TYPE_PLAIN);
		assertTrue("TextTag.TYPE_PLAIN == TYPE_PLAIN", Text.TYPE_PLAIN == TYPE_PLAIN);
	}
	
	public function testTYPE_TEXT() : void
	{
		assertNotNull("TextTag.TYPE_TEXT is null", Text.TYPE_TEXT);
		assertTrue("TextTag.TYPE_TEXT == TYPE_TEXT", Text.TYPE_TEXT == TYPE_TEXT);
	}

	public function testTYPE_HTML() : void
	{
		assertNotNull("TextTag.TYPE_HTML is null", Text.TYPE_HTML);
		assertTrue("TextTag.TYPE_HTML == TYPE_HTML", Text.TYPE_HTML == TYPE_HTML);
	}		

	public function testTYPE_XHTML() : void
	{
		assertNotNull("TextTag.TYPE_XHTML is null", Text.TYPE_XHTML);
		assertTrue("TextTag.TYPE_XHTML == TYPE_XHTML", Text.TYPE_XHTML == TYPE_XHTML);
	}			

	public function testType() : void
	{
		var tText : Text = new Text();
			tText.type = TYPE;
		
		assertNotNull("tText.type is null", tText.type);
		assertTrue("tText.type == TYPE", tText.type == TYPE);
	}

	public function testValue() : void
	{
		var tText : Text = new Text();
		
		tText.value = VALUE;
		
		assertNotNull("tText.value is null", tText.value);
		assertTrue("tText.value == VALUE", tText.value == VALUE);
	}
}
}