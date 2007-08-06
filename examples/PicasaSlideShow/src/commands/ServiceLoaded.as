import com.bourre.commands.Command;
import com.bourre.commands.Delegate;
import com.bourre.core.Model;
import com.bourre.events.BasicEvent;
import com.bourre.visual.MovieClipHelper;
import com.bourre.log.PixlibStringifier;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;

import view.ViewList;
import view.Photo;
import model.*;
import events.EventList;

/**
  @author Michal Gron (michal.gron@gmail.com)
 */
class commands.ServiceLoaded implements Command
{
	public function execute(e:BasicEvent):Void 
	{
		var tModel = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		var tPPS:Picasa.PhotoService = tModel.getPhotoService();
		var tPhotoContainer = MovieClipHelper.getMovieClipHelper(ViewList.PHOTO).view;
		var tCurrentOnFinished:String = "";
		var tLibStack:LibStack = new LibStack();
		
		for(var a = 0; a < tPPS.getPhotosCount(); a++)
		{
			var tPP:Picasa.Photo = tPPS.getNextPhoto();
			var tID:String = tPP.getIdString();
			
			if(!Photo.exists(tID))
			{
				if(a == 0) tCurrentOnFinished = tID;
				var tPhoto:Photo = new Photo(tID,tPhotoContainer,(a != 0));
					tPhoto.setTitle(tPP.getSummary());
					tPhoto.view.onRelease = Delegate.create(this, onPhotoClick);
					tModel.addEventListener(EventList.PHOTO_CLICK, tPhoto);					tModel.addEventListener(EventList.PHOTO_CHANGED, tPhoto);
					
					tLibStack.enqueue(new GraphicLib(tPhoto.view, 1), tID, tPP.getLink());
					tLibStack.addListener(tPhoto);
			} else
			{
				trace("Thumb "+tID+" already exists. Skipping!",Log.WARNING);
			}
		}
		tLibStack.execute();
		tModel.setCurrentPhoto(tCurrentOnFinished);
		tModel.startSlideShow();
	}
	public function onPhotoClick()
	{
		var tModel = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
			tModel.photoClick();
	}
	public function toString():String
	{
		return PixlibStringifier.stringify(this);
	}
}
