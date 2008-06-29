package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	
	import sk.prasa.webapis.picasa.PicasaResponder;
	import sk.prasa.webapis.picasa.events.PicasaDataEvent;
	import sk.prasa.webapis.picasa.objects.feed.AtomFeed;
	import sk.prasa.webapis.picasa.objects.feed.IAtom;	
	
	/**
	 * Receives and XML instance from GetFeedCommand.
	 * TODO: ... ERROR handling is here poor! what if passed wrong argument or wrong argument value?
	 * 
	 * @author Michal Gron (michal.gron@gmail.com) 
	 * @private
	 */
	public class GetFeedReceiver implements IReceiver
	{
		private var __responder : PicasaResponder;

		public function GetFeedReceiver()
		{
			__responder = new PicasaResponder();
		}
		
		/**
		 * Called when XML loading is complete. 
		 * 
		 * @param response XML Loaded XML document.
		 */
		public function process(response : XML) : void 
		{
			try
			{
				var tEvt : PicasaDataEvent = new PicasaDataEvent(PicasaDataEvent.DATA);
					tEvt.data = parse(response);
					
				responder.dispatchEvent(tEvt);
			} catch(e : Error)
			{
				throw new Error(e);
			}
		}

		/**
		 * Parse received XML document. 
		 * 
		 * TODO: ... RSS projection?.. make this factory method?
		 */
		protected function parse(aFeed : XML) : IAtom
		{
			var tFeed : IAtom = new AtomFeed(aFeed);
			return tFeed;
		}

		public function get responder() : PicasaResponder
		{
			return __responder;
		}
		
		/** 
		 * When the result event from the URLLoader is received.
		 */
		public function result(evt : Event) : void
		{
			var loader : URLLoader = URLLoader(evt.target); 
			process(new XML(loader.data));
		}

		/**
		 * When the fault event from the URLLoader is received. 
		 */
		public function fault(evt : ErrorEvent) : void
		{
			responder.dispatchEvent(evt);
		}

		/**
		 * When the URLLoader dispatches ProgressEvent, redispatch it.
		 */
		public function progress(evt : ProgressEvent) : void
		{
			responder.dispatchEvent(evt);
		}

		/** 
		 * The URLLoader has dispatched on Event.OPEN event.
		 */
		public function open(evt : Event) : void
		{
			responder.dispatchEvent(evt);
		}

		/**
		 * We have received an HTTPStatusEvent.STATUS from URLLoader.
		 * Usefull for determining errors.
		 */
		public function status(evt : HTTPStatusEvent) : void
		{
			responder.dispatchEvent(evt);
		}
	}
}