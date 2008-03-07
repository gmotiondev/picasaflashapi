import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.visual.MovieClipHelper;

import control.InitializeEvent;
import model.*;
import view.*;
import view.thumb.*;
import view.photo.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
 
class command.InitializeCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : InitializeEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		var tPhotosHolder : PhotosHolder = PhotosHolder(MovieClipHelper.getMovieClipHelper(ViewList.PHOTOS_HOLDER));
		var tThumbsHolder : ThumbsHolder = ThumbsHolder(MovieClipHelper.getMovieClipHelper(ViewList.THUMBS_HOLDER));

		var tPLibStack : LibStack = new LibStack();
			tPLibStack.addListener(tPhotosHolder);
			
		var tTLibStack : LibStack = new LibStack();
			tTLibStack.addListener(tThumbsHolder);

		for(var a : Number = 0; a < model.photos.length; a++)
		{
			var tItem : sk.prasa.webapis.picasa.Photo = model.photos[a];
			var tPhoto : Photo = tPhotosHolder.addChild(tItem.gphoto.id, (a != 0));
			var tThumb : Thumb = tThumbsHolder.addChild(tItem.gphoto.id, tItem.summary);
		
			model.addListener(tPhoto);
			model.addListener(tThumb);
			
			tPLibStack.enqueue(new GraphicLib(tPhoto.view, 5), tItem.gphoto.id, tItem.content.src);			
			tTLibStack.enqueue(new GraphicLib(tThumb.view, 5), tItem.gphoto.id, tItem.media.thumbnail[0].url);
		}
		
		tTLibStack.execute();
		tPLibStack.execute();
	}
}