/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;
import sk.prasa.webapis.picasa.events.PicasaResultEvent;

import model.*;
import command.IResponder;
import control.PhotosGetEvent;
import business.PhotosDelegate;

class command.PhotosGetCommand implements Command, IResponder
{
	private var model:ModelApplication = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)); 
	
	public function execute(e:PhotosGetEvent):Void
	{
		var tUserid:String = e.userid;
		var tAlbumid:String = e.albumid;
		
		var d:PhotosDelegate = new PhotosDelegate(this);
			d.list(tUserid, tAlbumid);
		
		trace("getting photos for user "+tUserid+" from album "+tAlbumid);
	}
	
	public function result(data:Array):Void
	{
		//trace("PhotosGetCommand success: "+data.length);
		//trace("data[5].id: "+data[5].id);
		for(var a:Number = 0; a < data.length; a++)
		{
			var tPhoto:Photo = data[a];
			trace(a+": "+tPhoto.id);
		}
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("PhotosGetCommand failed: "+error.message);
	}
}