/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.events.IEvent;
import com.bourre.core.Model;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.visual.MovieClipHelper;

import model.*;
import view.*;

class command.InitializeCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(e:IEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		var tPhotoHolder = MovieClipHelper.getMovieClipHelper(ViewList.PHOTO_HOLDER);
		var tThumbHolder = MovieClipHelper.getMovieClipHelper(ViewList.THUMB_HOLDER);
		var tTLibStack:LibStack = new LibStack();
		
		for(var a:Number = 0; a < model.photos.length; a++)
		{
			var tItem:sk.prasa.webapis.picasa.Photo = model.photos[a];
			var tPhoto:view.Photo = tPhotoHolder.addChild(tItem.gphoto.id, tItem.media.content.url);
			var tThumb:view.Thumb = tThumbHolder.addChild(tItem.gphoto.id, tItem.summary);
			
			model.addListener(tPhoto);
			model.addListener(tThumb);

			tTLibStack.enqueue(new GraphicLib(tThumb.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
			tTLibStack.addListener(tThumbHolder);
		}
		
		tThumbHolder.setTitle(model.photos[0].album.title+" ("+model.photos[0].album.gphoto.numphotos+")");
		tTLibStack.execute();
	}
}