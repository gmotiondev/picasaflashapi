/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.core.Model;
import com.bourre.commands.Delegate;

import sk.prasa.webapis.picasa.PicasaService;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import model.*;
import command.IResponder;

class business.PhotosDelegate
{
	private var __command:IResponder;
	private var __service:PicasaService;
	
	public function PhotosDelegate(command:IResponder)
	{
		__command = command;
		__service = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).service;
	}
	
	public function list(aUserid:String, aAlbumid:String):Void
	{
		// add progress, but don't chain the classes!
		// maybe an event service listner, command etc.. 
		__service.addEventListener(PicasaResultEvent.PHOTOS_LIST, Delegate.create(this, list_complete));
		__service.photos.list(aUserid, aAlbumid);
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
			__service.removeEventListener(PicasaResultEvent.PHOTOS_LIST, list_complete);
		}
	}
}