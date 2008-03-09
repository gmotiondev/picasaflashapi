/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import asunit.framework.TestCaseXml;
import asunit.framework.TestCase;

import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.events.*;
import sk.prasa.webapis.picasa.core.*;

class sk.prasa.webapis.picasa.tests.tags.TagsPhoto extends TestCase
{
	private var className:String = "TagsPhoto";
	private var service:PicasaService;
	private var xmlData:Comments;
	private var event:PicasaResultEvent;
	
	public function TagsPhoto(testMethod:String)
	{
		super(testMethod);
	}
	
	public function run():Void
	{
		service = new PicasaService();
		
		service.addEventListener(PicasaResultEvent.TAGS_GET_PHOTO, this);
		service.tags.photo("picasaflashapi","5134889498689547361","5134889597473795202");
	}

	private function tagsGetPhoto(evt:PicasaResultEvent):Void
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
