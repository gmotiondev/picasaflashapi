/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
import com.bourre.commands.Command;
import com.bourre.events.IEvent;
import com.bourre.core.Model;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.visual.MovieClipHelper;
import sk.prasa.webapis.picasa.Photo;

import model.*;
import view.*;

class command.InitializeCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(e:IEvent):Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		var tPhotoHolder = MovieClipHelper.getMovieClipHelper(ViewList.PHOTO_HOLDER);
		var tLibStack:LibStack = new LibStack();
		
		for(var a:Number = 0; a < model.photos.length; a++)
		{
			var tItem:Photo = model.photos[a];
			var tContainer:MovieClip = tPhotoHolder.view.createEmptyMovieClip("p_"+tItem.gphoto.id, tPhotoHolder.view.getNextHighestDepth());
			var tPhotoContainer:PhotoContainer = new PhotoContainer(tItem.gphoto.id, tContainer, (a != 0));
				
				model.addListener(tPhotoContainer);
				
				tLibStack.enqueue(new GraphicLib(tPhotoContainer.view, 5), tItem.gphoto.id, tItem.content.src);
				tLibStack.addListener(tPhotoHolder);
		}
		
		tLibStack.execute();
	}
}