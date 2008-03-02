/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;

import model.*;
import command.*;
import control.*;
import business.*;

class command.PhotosGetCommand implements Command, IResponder
{
	private var model : ModelApplication; 
	
	public function execute(e:PhotosGetEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tUserid:String = e.userid;
		var tAlbumid:String = e.albumid;
		
		var d:PhotosDelegate = new PhotosDelegate(this);
			d.list(tUserid, tAlbumid);
	}
	
	public function result(data:Array) : Void
	{
		for(var a:Number = 0; a < data.length; a++)
		{
			var tPhoto:Photo = data[a];
			model.photos.push(tPhoto);
		}
		
		EventBroadcaster.getInstance().dispatchEvent(new InitializeEvent());
	}
	
	public function fault(error:PicasaError) : Void
	{
		trace("PhotosGetCommand failed: "+error.message);
	}
}