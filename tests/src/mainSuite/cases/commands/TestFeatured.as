package mainSuite.cases.commands 
{
	import sk.prasa.webapis.picasa.objects.feed.Meta;
import net.digitalprimates.fluint.tests.TestCase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.UrlParams;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
/**
 * 
 */
public class TestFeatured extends TestCase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{		
		var service : PicasaService = new PicasaService();
		var params : UrlParams = new UrlParams();
			params.max_results = 25;
		var responder : PicasaResponder = service.photos.featured(params);
			responder.addEventListener( PicasaDataEvent.DATA, 
										asyncHandler(setUpComplete, 1000),
										false, 0, true);
	}
	
	override protected function tearDown() : void
	{
		atom = null;
	}
	
	protected function setUpComplete(evt : PicasaDataEvent, passThroughData : Object) : void
	{
		atom = evt.data;
	}
	
	public function testFeatured() : void
	{
		assertNotNull(atom);
		assertNotNull(atom.meta);
		assertNotNull(atom.entries);
		
		assertTrue(atom.meta is Meta);
		assertNotNull(atom.entries);
		assertTrue(atom.entries is Array);
		assertEquals(atom.entries.length, 25);
	}
}
}