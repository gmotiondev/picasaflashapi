/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.commands.Delegate;
import com.bourre.events.NumberEvent;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import model.*;
import command.IResponder;
import control.*;

class business.AlbumsDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function AlbumsDelegate(command:IResponder)
	{
		__command = command;
		__service = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function list(aUserid:String):Void
	{
		// add progress, but don't chain the classes!
		// maybe an event service listner, command etc..
		// EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(e.getPerCent()));
		__service.addEventListener(PicasaService.PROGRESS, list_progress); 
		__service.addEventListener(PicasaResultEvent.ALBUMS_LIST, Delegate.create(this, list_complete));
		__service.albums.list(aUserid);
	}

	public function list_complete(e:PicasaResultEvent):Void
	{
		try
		{
			if(e.success) {
				__command.result(e.data);
			} else {
				__command.fault(e.error);
			}
		} catch(error:Error)
		{
			trace("list_complete failed: "+error.message)
		} finally
		{
			__service.removeEventListener(PicasaResultEvent.ALBUMS_LIST, list_complete);
		}
	}
	
	private function list_progress(e:NumberEvent):Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new ProgressSetEvent(NumberEvent(e).getNumber()));
	}
}