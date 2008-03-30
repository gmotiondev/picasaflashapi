/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import asunit.framework.TestCaseXml;
import asunit.framework.TestCase;

import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.events.*;
import sk.prasa.webapis.picasa.core.*;

class sk.prasa.webapis.picasa.tests.photos.PhotosListByTag extends TestCase
{
	private var className:String = "PhotosListByTag";
	private var service:PicasaService;
	private var xmlData:Albums;
	private var event:PicasaEvent;
	
	public function PhotosListByTag(testMethod:String)
	{
		super(testMethod);
	}
	
	public function run():Void
	{
		service = new PicasaService();
		
		service.addEventListener(PicasaEvent.PHOTOS_GET_LIST_BY_TAG, this);
		service.photos.list_by_tag("picasaflashapi","5134889498689547361","even");
	}

	private function photosGetListByTag(evt:PicasaEvent):Void
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
		assertTrue("photo list by tag failed: "+event.error.message, event.success);
	}
	
	public function test_data():Void
	{
		for(var a:Number = 0; a < event.data.length; a++)
		{
			assertTrue("is even? "+event.data[a].media.keywords[0], event.data[a].media.keywords[0] == "even");
		}
	}
}
