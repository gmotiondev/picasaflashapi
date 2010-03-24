package mainSuite.cases.objects
{
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.objects.Link;
public class TestLink extends TestCase 
{
	private const TYPE : String = "text/html";
	private const REL : String = "alternate";
	private const HREF : String = "http://picasaweb.google.com/thisispinkfu";
	private const HREFLANG : String = null;
	private const TITLE : String = null;
	private const LENGTH : Number = 0;
	private static const REL_ALTERNATE : String = "alternate";
	private static const REL_RELATED : String = "related";
	private static const REL_SELF : String = "self";
	private static const REL_ENCLOSURE : String = "enclosure";
	private static const REL_VIA : String = "via";

	public function testLength() : void
	{
		var tLink : Link = new Link();
			tLink.length = LENGTH;
		
		assertTrue("!isNaN(tLink.length)", !isNaN(tLink.length));
		assertTrue("tLink.length == LENGTH", tLink.length == LENGTH);
	}		

	public function testTitle() : void
	{
		var tLink : Link = new Link();
			tLink.title = TITLE;
		
		assertNull("tLink.title is not null", tLink.title);
		assertTrue("tLink.title == TITLE", tLink.title == TITLE);
	}			

	public function testLink() : void
	{
		var tLink : Link = new Link();
			tLink.href = HREF;
		
		assertNotNull("tLink.href is null", tLink.href);
		assertTrue("tLink.href == HREF", tLink.href == HREF);
	}

	public function testHrefLang() : void
	{
		var tLink : Link = new Link();
			tLink.hreflang = HREFLANG;
		
		assertNull("tLink.hreflang is not null", tLink.hreflang);
		assertTrue("tLink.hreflang == HREFLANG", tLink.hreflang == HREFLANG);
	}		

	public function testRel() : void
	{
		var tLink : Link = new Link();
			tLink.rel = REL;
		
		assertNotNull("tLink.rel is null", tLink.rel);
		assertTrue("tLink.rel == REL", tLink.rel == REL);
	}

	public function testType() : void
	{
		var tLink : Link = new Link();
			tLink.type = TYPE;
		
		assertNotNull("tLink.type is null", tLink.type);
		assertTrue("tLink.type == TYPE", tLink.type == TYPE);
	}

	public function testREL_VIA() : void
	{
		assertNotNull("Link.REL_VIA is null", Link.REL_VIA);
		assertTrue("Link.REL_VIA == REL_VIA", Link.REL_VIA == REL_VIA);
	}

	public function testREL_ENCLOSURE() : void
	{
		assertNotNull("Link.REL_ENCLOSURE is null", Link.REL_ENCLOSURE);
		assertTrue("Link.REL_ENCLOSURE == REL_ENCLOSURE", Link.REL_ENCLOSURE == REL_ENCLOSURE);
	}

	public function testREL_SELF() : void
	{
		assertNotNull("Link.REL_SELF is null", Link.REL_SELF);
		assertTrue("Link.REL_SELF == REL_SELF", Link.REL_SELF == REL_SELF);
	}

	public function testREL_ALTERNATE() : void
	{
		assertNotNull("Link.REL_ALTERNATE is null", Link.REL_ALTERNATE);
		assertTrue("Link.REL_ALTERNATE == REL_ALTERNATE", Link.REL_ALTERNATE == REL_ALTERNATE);
	}

	public function testREL_RELATED() : void
	{
		assertNotNull("Link.REL_RELATED is null", Link.REL_RELATED);
		assertTrue("Link.REL_RELATED == REL_RELATED", Link.REL_RELATED == REL_RELATED);
	}
}
}