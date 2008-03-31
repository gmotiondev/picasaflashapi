/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.core.*;
import sk.prasa.webapis.picasa.events.*;
class sk.prasa.webapis.picasa.tests.comments.CommentsPhoto extends TestCase
{
	private var className:String = "CommentsPhoto";
	private var service:PicasaService;
	private var xmlData:Comments;
	private var event:PicasaEvent;
	
	public function CommentsPhoto(testMethod:String)
	{
		super(testMethod);
	}
	
	public function run():Void
	{
		service = new PicasaService();
		
		service.addEventListener(PicasaEvent.COMMENTS_GET_PHOTO, this);
		service.comments.photo("picasaflashapi","5134889498689547361","5134889597473795202");
	}

	private function commentsGetPhoto(evt:PicasaEvent):Void
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
		assertTrue("comments photo failed: "+event.error.message, event.success);
	}
	
	public function test_data():Void
	{
		for(var a:Number = 0; a < event.data.length; a++)
		{
			assertNotUndefined("comment ("+event.data[a].content+") for photo "+event.data[a].gphoto.photoid+" is undefined", event.data[a].content);
		}
	}
}
