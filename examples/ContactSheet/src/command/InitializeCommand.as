import view.thumb.Thumb;
import view.photo.Photo;
import view.thumb.ThumbsView;
import view.photo.PhotosView;

import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.libs.LibStack;
import com.bourre.data.libs.GraphicLib;
import com.bourre.visual.MovieClipHelper;

import model.*;
import view.*;
import control.InitializeEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class command.InitializeCommand implements Command
{
	private var model : ModelApplication; 
	
	public function execute(evt : InitializeEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));

		var tPhotosView : PhotosView = PhotosView(MovieClipHelper.getMovieClipHelper(ViewList.PHOTOS_VIEW));
		var tThumbsView : ThumbsView = ThumbsView(MovieClipHelper.getMovieClipHelper(ViewList.THUMBS_VIEW));
		
		var tStack : LibStack = new LibStack();
		
		for(var a : Number = 0; a < model.photos.length; a++)
		{
			var tItem : sk.prasa.webapis.picasa.Photo = model.photos[a];
			var tPhoto : Photo = tPhotosView.addChild(tItem.gphoto.id, tItem.media.content.url);
			var tThumb : Thumb = tThumbsView.addChild(tItem.gphoto.id);
			
			model.addListener(tPhoto);
			model.addListener(tThumb);

			tStack.enqueue(new GraphicLib(tThumb.view, 5), "thumb_gl_" + tItem.gphoto.id, tItem.media.thumbnail[0].url);
			tStack.addListener(tThumbsView);
		}
		
		tThumbsView.setTitle(model.photos[0].album.title+" ("+model.photos[0].album.gphoto.numphotos+")");
		tStack.execute();
	}
}