import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.EventBroadcaster;

import business.*;

import command.*;

import control.*;

import model.*;

import sk.prasa.webapis.picasa.Album;
import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.Photo;
import sk.prasa.webapis.picasa.PicasaError;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.InitializePhotosCommand implements Command, IResponder
{
	private var model:ModelApplication; 
	
	public function execute(evt : InitializePhotosEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		if(!model.photos.containsAlbum(evt.albumid))
		{
			var d : PhotosDelegate = new PhotosDelegate(this);
				d.list(evt.userid, evt.albumid);
		}
	}

	public function result(data:Array):Void
	{
		var tAlbumid : String;
		
		for(var a:Number = 0; a < data.length; a++)
		{
			var tPhoto : Photo = data[a];
			model.photos.push(tPhoto);
			tAlbumid = tPhoto.album.gphoto.id;
		}
		
		EventBroadcaster.getInstance().broadcastEvent(new SetPhotosThumbEvent(tAlbumid));
	}
	
	public function fault(error:PicasaError):Void
	{
		trace("InitializePhotosCommand failed: "+error.message);
	}
}