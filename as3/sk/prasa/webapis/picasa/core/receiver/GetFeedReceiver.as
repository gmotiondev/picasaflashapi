package sk.prasa.webapis.picasa.core.receiver 
{	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	
	import sk.prasa.webapis.picasa.Tag;
	import sk.prasa.webapis.picasa.Comment;
	import sk.prasa.webapis.picasa.Photo;
	import sk.prasa.webapis.picasa.Album;
	import sk.prasa.webapis.picasa.KindType;

	import sk.prasa.webapis.picasa.PicasaError;
	import sk.prasa.webapis.picasa.events.PicasaEvent;
	import sk.prasa.webapis.picasa.PicasaService;
	import sk.prasa.webapis.generic.events.ServiceEvent;
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */
	
	public class GetFeedReceiver implements IReceiver
	{
		private var service : PicasaService;
		private namespace atom = "http://www.w3.org/2005/Atom";
		
		public function GetFeedReceiver(srv : PicasaService)
		{
			service = srv;
		}
		
		public function process(response : XML, eventType : String) : void 
		{
			try
			{
				var tEvt : PicasaEvent = new PicasaEvent(eventType);
					tEvt.success = true;
					tEvt.data = parse(response);
					
					service.dispatchEvent(tEvt);
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
						case KindType.ALBUM		: tRes.push(new Album(tItem, tParent)); break;
						case KindType.PHOTO		: tRes.push(new Photo(tItem, tParent)); break;
						case KindType.COMMENT 	: tRes.push(new Comment(tItem, tParent)); break;
						case KindType.TAG 		: tRes.push(new Tag(tItem, tParent)); break;
						default: break;
					}
				}

				return tRes;
			} catch(e : Error)
			{
				throw new Error(e);
			}

			return null;
		}
		
		public function result(evt : Event) : void
		{
			throw new Error(PicasaError.ABSTRACT_METHOD_ERROR);
		}

		public function fault(evt : IOErrorEvent) : void
		{
			var tEvt : PicasaEvent = new PicasaEvent(IOErrorEvent.IO_ERROR);
				tEvt.success = false;
				tEvt.error = new PicasaError(evt.text);
			
			service.dispatchEvent(tEvt);
		}
	}
}
