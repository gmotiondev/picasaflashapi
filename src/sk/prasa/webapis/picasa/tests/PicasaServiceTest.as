/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import asunit.framework.TestCaseXml;
import asunit.framework.TestCase;
import sk.prasa.webapis.picasa.PicasaService;

class sk.prasa.webapis.picasa.tests.PicasaServiceTest extends TestCase
{
	private var className:String = "PicasaServiceTest";
	private var instance:PicasaService;
	private var xmlData:TestCaseXml;

	public function PicasaServiceTest(testMethod:String) {
		super(testMethod);
	}
	
	/*public function run():Void {
		xmlData = new TestCaseXml("pathToYourXmlFile.xml", this);
	}*/

	/*public function onXmlLoaded(node:XMLNode):Void {
		super.run();
	}*/

	public function setUp():Void {
		//var data:XMLNode = xmlData.cloneNode(true);
		instance = new PicasaService();
	}

	public function tearDown():Void {
		delete instance;
	}

	public function testInstantiated():Void {
		assertTrue("PicasaService instantiated", instance instanceof PicasaService);
	}

	public function test():Void {
		assertTrue("failing test", false);
	}

	/*public function testAdd():Void
	{
		var result:Number = instance.add(2,3);
		assertTrue("Expected:5 Received:"+result, result==5);
	}*/
	
	public function test_api_key():Void
	{
		assertNotUndefined("api_key is "+instance.api_key+", picasa doesn't use api_key right now!", instance.api_key);

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
}
