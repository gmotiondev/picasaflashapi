import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.events.BasicEvent;
import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;

import uis.uilist;
import uis.Photo;
import models.*;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class controllers.ServiceLoaded implements Command
{
	public function execute(e:BasicEvent):Void 
	{
		var tModel = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		var tPPS:Picasa.PhotoService = e.getTarget();
		var tPhotoContainer = MovieClipHelper.getMovieClipHelper(uilist.PHOTO).view;
		var tCurrentOnFinished:String = "";
		
		for(var a = 0; a < tPPS.getPhotosCount(); a++)
		{
			var tPP:Picasa.Photo = tPPS.getNextPhoto();
			var tID:String = tPP.getIdString();
			
			if(!Photo.exists(tID))
			{
				if(a == 0) tCurrentOnFinished = tID;
				var tPhoto:Photo = new Photo(tID,tPhotoContainer,(a != 0));
					tPhoto.setTitle(tPP.getSummary()+"("+tPP.getTitle()+")");
					tModel.addListener(tPhoto);
					tPhoto.load(tPP.getLink());
			} else
			{
				trace("Thumb "+tID+" already exists. Skipping!",Log.WARNING);
			}
		}
		tModel.setCurrentPhoto(tCurrentOnFinished);
		tModel.startSlideShow();
	}
	
	public function notify(aPP:Picasa.Photo):Void
	{
		ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION)).PhotoThumbClick(aPP);
	}
	
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}
