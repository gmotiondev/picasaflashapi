package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import sk.prasa.webapis.picasa.objects.Album;
	import sk.prasa.webapis.picasa.objects.Comment;
	import sk.prasa.webapis.picasa.objects.KindType;
	import sk.prasa.webapis.picasa.objects.Photo;
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.objects.Tag;
	import sk.prasa.webapis.picasa.events.*;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public class GetFeedReceiver implements IReceiver
	{
		private var __responder : PicasaResponder;
		
		private namespace atom = "http://www.w3.org/2005/Atom";

		public function GetFeedReceiver()
		{
			__responder = new PicasaResponder();
		}

		public function process(response : XML) : void 
		{
			try
			{
				var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.COMPLETE);
					tEvt.data = parse(response);
					
				responder.dispatchEvent(tEvt);
			} catch(e : Error)
			{
				throw new Error(e);
			}
		}

		private function parse(aItems : XML) : Array
		{
			use namespace atom;
			
			try
			{
				var tRes : Array = new Array();
				var tParent : XML = new XML(aItems);
				delete tParent.entry;
				
				//var tRg : RegExp = /#([\w\-]+)/;

				for each(var tItem : XML in aItems.entry)
				{
					var tKind : String = (tItem.category.@term).split("#")[1];
					
					switch(tKind)
					{
						//case KindType.USER	: tRes.push(new User(tItem)); break;
						case KindType.ALBUM		: 
							tRes.push(new Album(tItem, tParent)); 
							break;
						case KindType.PHOTO		: 
							tRes.push(new Photo(tItem, tParent)); 
							break;
						case KindType.COMMENT 	: 
							tRes.push(new Comment(tItem, tParent)); 
							break;
						case KindType.TAG 		: 
							tRes.push(new Tag(tItem, tParent)); 
							break;
						default: 
							break;
					}
				}

				return tRes;
			} catch(e : Error)
			{
				throw new Error(e);
			}

			return null;
		}

		public function get responder() : PicasaResponder
		{
			return __responder;
		}

		public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target); 
			process(new XML(loader.data));
		}

		public function fault(evt : ErrorEvent) : void
		{
			responder.dispatchEvent(new PicasaErrorEvent(PicasaErrorEvent.ERROR, evt.bubbles, evt.cancelable, evt.text));
		}

		public function progress(evt : ProgressEvent) : void
		{
			responder.dispatchEvent(new PicasaProgressEvent(PicasaProgressEvent.PROGRESS, evt.bubbles, evt.cancelable, evt.bytesLoaded, evt.bytesTotal));
		}

		public function open(evt : Event) : void
		{
			responder.dispatchEvent(new PicasaEvent(PicasaEvent.OPEN));
		}

		public function status(evt : HTTPStatusEvent) : void
		{
			if(evt.status >= 300)
			{
				responder.dispatchEvent(new PicasaErrorEvent(PicasaErrorEvent.ERROR, evt.bubbles, evt.cancelable, "HTTPStatus error: " + evt.status));
			}
			
			responder.dispatchEvent(new PicasaStatusEvent(PicasaStatusEvent.STATUS, evt.bubbles, evt.cancelable, evt.status));
		}
	}
}
