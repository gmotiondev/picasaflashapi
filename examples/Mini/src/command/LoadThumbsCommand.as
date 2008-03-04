import com.bourre.events.IEvent;
import com.bourre.data.libs.GraphicLib;

import sk.prasa.webapis.picasa.Photo;

import view.*;
import control.*;
import model.*;

import com.bourre.data.libs.LibStack;
import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.LoadThumbsCommand implements Command
{
	private var model : ModelApplication;

	public function execute(evt : LoadThumbsEvent) : Void 
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tThumbs : Thumbs = Thumbs(MovieClipHelper.getMovieClipHelper(ViewList.THUMBSVIEW));
		var tStack : LibStack = new LibStack();
		
		for(var a : Number = 0; a < model.photos.length; a++)
		{
			var tItem : Photo = model.photos[a];
			var tThumb : Thumb = tThumbs.addChild(tItem.gphoto.id);
			tStack.enqueue(new GraphicLib(tThumb.view, 2), "gl_"+tItem.gphoto.id, tItem.media.thumbnail[0].url);
			tStack.addListener(tThumbs);
		}
		
		tStack.execute();
	}
}