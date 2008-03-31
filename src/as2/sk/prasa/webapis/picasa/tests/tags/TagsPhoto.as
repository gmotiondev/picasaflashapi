/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.*;
import sk.prasa.webapis.picasa.events.*;
class sk.prasa.webapis.picasa.tests.tags.TagsPhoto extends TestCase
{
	private var className:String = "TagsPhoto";
	private var service:PicasaService;
	private var xmlData:Comments;
	private var event:PicasaEvent;
	
	public function TagsPhoto(testMethod:String)
	{
		super(testMethod);
	}
	
	public function run():Void
	{
		service = new PicasaService();
		
		service.addEventListener(PicasaEvent.TAGS_GET_PHOTO, this);
		service.tags.photo("picasaflashapi","5134889498689547361","5134889597473795202");
	}

	private function tagsGetPhoto(evt:PicasaEvent):Void
	{
		event = evt;
		
		super.run();
	}
	
	public function setUp():Void
	{
	}

	public function tearDown():Void
	{
		delete service;
	}

	public function testInstantiated():Void
	{
		assertTrue("PicasaService instantiated", service instanceof PicasaService);
	}
	
	public function test_success():Void
	{
		assertTrue("tags photo failed: "+event.error.message, event.success);
	}
	
	public function test_data():Void
	{
		for(var a:Number = 0; a < event.data.length; a++)
		{
			assertNotUndefined("photo tag ("+event.data[a].title+") is undefined", event.data[a].title);
		}
	}
}
