package sk.prasa.webapis.picasa.core.receiver 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.ProgressEvent;

	import sk.prasa.webapis.picasa.PicasaResponder;	
	
	/**
	 * @author Michal Gron (michal.gron@gmail.com)
	 */

	public interface IReceiver
	{
		function open(evt : Event) : void;
		function result(evt : Event) : void;
		function fault(evt : ErrorEvent) : void;
		function progress(evt : ProgressEvent) : void;
		function status(evt : HTTPStatusEvent) : void;
		function get responder() : PicasaResponder;
	}
}
