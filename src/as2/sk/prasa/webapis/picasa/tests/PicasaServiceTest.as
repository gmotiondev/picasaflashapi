/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.*;
class sk.prasa.webapis.picasa.tests.PicasaServiceTest extends TestCase
{
	private var className:String = "PicasaServiceTest";
	private var service:PicasaService;
	private var xmlData:TestCaseXml;

	public function PicasaServiceTest(testMethod:String) {
		super(testMethod);
	}

	public function setUp():Void {
		service = new PicasaService();
	}

	public function tearDown():Void {
		delete service;
	}

	public function testInstantiated():Void {
		assertTrue("PicasaService instantiated", service instanceof PicasaService);
	}

	public function test_api_key():Void
	{
		assertUndefined("api_key is "+service.api_key+", picasa doesn't use api_key right now!", service.api_key);

		/*
		assertTrue(msg:Object, assertion:Boolean)
		assertFalse(msg:Object, assertion:Boolean)
		assertEquals(msg:Object, assertion1:Object, assertion2:Object)
		assertSame(msg:Object, object1:Object, object2:Object)
		assertNotNull(msg:Object, assertion:Object)
		assertNull(msg:Object, assertion:Object)
		assertUndefined(msg:Object, assertion:Object)
		assertNotUndefined(msg:Object, assertion:Object)
		fail( userMessage:String )
		*/
	}
	
	public function test_core_methods():Void
	{
		assertTrue("Auth not initialized", service.auth instanceof Auth);
		assertTrue("Photos not initialized", service.photos instanceof Photos);
		assertTrue("Albums not initialized", service.albums instanceof Albums);
		assertTrue("Tags not initialized", service.tags instanceof Tags);
		assertTrue("Comments not initialized", service.comments instanceof Comments);
		assertTrue("Community not initialized", service.community instanceof Community);
	}
}
