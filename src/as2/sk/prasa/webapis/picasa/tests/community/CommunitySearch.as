/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import asunit.framework.TestCaseXml;
import asunit.framework.TestCase;

import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.events.*;
import sk.prasa.webapis.picasa.core.*;

class sk.prasa.webapis.picasa.tests.community.CommunitySearch extends TestCase
{
	private var className:String = "CommunitySearch";
	private var service:PicasaService;
	private var xmlData:Comments;
	private var event:PicasaResultEvent;
	
	public function CommunitySearch(testMethod:String)
	{
		super(testMethod);
	}
	
	public function run():Void
	{
		service = new PicasaService();
		var tUrlParams:UrlParams = new UrlParams();
			tUrlParams.max_results = 25;
			
		service.addEventListener(PicasaResultEvent.COMMUNITY_GET_SEARCH, this);
		service.community.search("lomo", tUrlParams);
	}

	private function communityGetSearch(evt:PicasaResultEvent):Void
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
		assertTrue("community search failed: "+event.error.message, event.success);
	}
	
	public function test_data():Void
	{
		for(var a:Number = 0; a < event.data.length; a++)
		{
			assertNotUndefined("photo ("+event.data[a].content+") for album "+event.data[a].gphoto.albumid+" is undefined", event.data[a].content);
		}
	}
}
