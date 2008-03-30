/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import asunit.framework.TestCaseXml;
import asunit.framework.TestCase;

import sk.prasa.webapis.picasa.*;
import sk.prasa.webapis.picasa.events.*;
import sk.prasa.webapis.picasa.core.*;

class sk.prasa.webapis.picasa.tests.albums.AlbumsList extends TestCase
{
	private var className:String = "AlbumsList";
	private var service:PicasaService;
	private var xmlData:Albums;
	private var event:PicasaEvent;
	
	public function AlbumsList(testMethod:String)
	{
		super(testMethod);
	}
	
	public function run():Void
	{
		service = new PicasaService();
		
		service.addEventListener(PicasaEvent.ALBUMS_GET_LIST, this);
		service.albums.list("picasaflashapi");
	}

	private function albumsGetList(evt:PicasaEvent):Void
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
		assertTrue("albums list failed: "+event.error.message, event.success);
	}
	
	public function test_data():Void
	{
		assertTrue("id: "+event.data[0].user.id, event.data[0].user.id == "http://picasaweb.google.com/data/feed/api/user/picasaflashapi");
		assertTrue("title: "+event.data[0].user.title, event.data[0].user.title == "picasaflashapi");
		assertTrue("author.name: "+event.data[0].user.author.name, event.data[0].user.author.name == "Zuzana");
		assertTrue("author.uri: "+event.data[0].user.author.uri, event.data[0].user.author.uri == "http://picasaweb.google.com/picasaflashapi");
		assertTrue("generator.name: "+event.data[0].user.generator.name, event.data[0].user.generator.name == "Picasaweb");
	}
}
