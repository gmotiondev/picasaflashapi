package mainSuite.cases.objects.feed
{
import mainSuite.cases.TestBase;

import sk.prasa.webapis.picasa.PicasaResponder;
import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaDataEvent;
import sk.prasa.webapis.picasa.objects.feed.IAtom;
import sk.prasa.webapis.picasa.objects.feed.Meta;
/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 // todo: test user meta, album meta, photo meta, meta
public class TestAtomFeed extends TestBase 
{
	protected var atom : IAtom;
	
	override protected function setUp() : void
	{
		fixtures_path = "src/assets/fixtures/feed/api/";	
		
		var service : PicasaService = new PicasaService();
		var responder : PicasaResponder = service.albums.list("thisispinkfu");
			responder.addEventListener( PicasaDataEvent.DATA, 
										asyncHandler(setUpComplete, 1000),
										false, 0, true);
	}
	
	override protected function tearDown() : void
	{
		fixtures_path = null;
		atom = null;
	}
	
	protected function setUpComplete(evt : PicasaDataEvent, passThroughData : Object) : void
	{
		atom = evt.data;
	}
	
	public function testAtomFeed() : void
	{
		assertNotNull(atom);
		
		assertNotNull(atom.meta);
		assertTrue(atom.meta is Meta);
		
		assertNotNull(atom.entries);
		assertTrue(atom.entries is Array);
		assertTrue(atom.entries.length > 0);
	}
}
}