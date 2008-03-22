package sk.prasa.webapis.picasa.core.receiver 
{
	import sk.prasa.webapis.picasa.Tag;	
	import sk.prasa.webapis.picasa.Comment;	
	import sk.prasa.webapis.picasa.Photo;	
	import sk.prasa.webapis.picasa.Album;	
	import sk.prasa.webapis.picasa.KindType;	
	
	import mx.collections.ArrayCollection;	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	import sk.prasa.webapis.picasa.PicasaError;
	import sk.prasa.webapis.picasa.events.PicasaResultEvent;
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
				var tEvt : PicasaResultEvent = new PicasaResultEvent(eventType);
					tEvt.success = true;
					tEvt.target = parse(response);
					
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
					trace("parsing "+tKind);
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
			var tEvt : PicasaResultEvent = new PicasaResultEvent(PicasaResultEvent.IO_ERROR_EVENT);
				tEvt.success = false;
				tEvt.error = new PicasaError(evt.fault.faultString);
			
			service.dispatchEvent(tEvt);
		}
	}
}
