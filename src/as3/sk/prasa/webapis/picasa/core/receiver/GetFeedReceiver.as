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
	 * @author Michal Gron (michal.gron@gmail.com)
	 * TODO: ... ERROR handling is here poor! what if passed wrong argument or wrong argument value?
	 * TODO: ... the parse is overriden by subclasses, but the user doesn't what type of feed is he receiving!
	 * @private
	 */
	public class GetFeedReceiver implements IReceiver
	{
		private var __responder : PicasaResponder;

		public function GetFeedReceiver()
		{
			__responder = new PicasaResponder();
		}

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

		protected function parse(aFeed : XML) : IAtom
		{
			var tFeed : IAtom = new AtomFeed(aFeed);
			return tFeed;
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
			responder.dispatchEvent(evt);
		}

		public function progress(evt : ProgressEvent) : void
		{
			responder.dispatchEvent(evt);
		}

		public function open(evt : Event) : void
		{
			responder.dispatchEvent(evt);
		}

		public function status(evt : HTTPStatusEvent) : void
		{
			responder.dispatchEvent(evt);
		}
	}
}