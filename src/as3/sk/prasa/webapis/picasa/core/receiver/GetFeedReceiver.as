package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.IOErrorEvent;
	
	import sk.prasa.webapis.picasa.Tag;
	import sk.prasa.webapis.picasa.Comment;
	import sk.prasa.webapis.picasa.Photo;
	import sk.prasa.webapis.picasa.Album;
	import sk.prasa.webapis.picasa.KindType;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

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
		
		public function GetFeedReceiver()
		{
			service = PicasaService.getInstance();
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
		
		private function parse(o : XML) : ArrayCollection
		{
			use namespace atom;
			
			try
			{
				var tRes : ArrayCollection = new ArrayCollection();
				var tParent : XML = new XML(o);
					delete tParent.entry;
				
				//var tRg : RegExp = /#([\w\-]+)/;
				
				for each(var tItem : XML in o.entry)
				{
					var tKind : String = (tItem.category.@term).split("#")[1];
					
					switch(tKind)
					{
						case KindType.ALBUM	: tRes.addItem(new Album(tItem, tParent)); break;
						case KindType.PHOTO	: tRes.addItem(new Photo(tItem, tParent)); break;
						case KindType.COMMENT : tRes.addItem(new Comment(tItem, tParent)); break;
						case KindType.TAG : tRes.addItem(new Tag(tItem, tParent)); break;
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
		
		public function result(evt : ResultEvent) : void
		{
			throw new Error(PicasaError.ABSTRACT_METHOD_ERROR);
		}

		public function fault(evt : FaultEvent) : void
		{
			var tEvt : PicasaEvent = new PicasaEvent(IOErrorEvent.IO_ERROR);
				tEvt.success = false;
				tEvt.error = new PicasaError(evt.fault.faultString);
			
			service.dispatchEvent(tEvt);
		}
	}
}
