import com.bourre.commands.Command;
import com.bourre.core.Model;
import com.bourre.data.libs.GraphicLib;
import com.bourre.data.libs.LibStack;
import com.bourre.visual.MovieClipHelper;

import command.*;

import control.*;

import model.*;

import sk.prasa.webapis.picasa.GPhoto;
import sk.prasa.webapis.picasa.Photo;

import view.*;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */
class command.InitializePhotoCommand implements Command
{
	private var model:ModelApplication; 
	
	public function execute(evt : InitializePhotoEvent) : Void
	{
		model = ModelApplication(Model.getModel(ModelList.MODEL_APPLICATION));
		
		var tApp : Application = Application(MovieClipHelper.getMovieClipHelper(ViewList.APPLICATION));
		var tPhotoView : PhotoView = new PhotoView("photo_view_" + evt.id, tApp.view.createEmptyMovieClip(evt.id, tApp.view.getNextHighestDepth()));
		var tItem : Photo = model.photos.getPhotoById(evt.id);
		
		model.addListener(tPhotoView);
		
		var tLibStack : LibStack = new LibStack();
			tLibStack.addListener(tPhotoView);			
			tLibStack.enqueue(new GraphicLib(tPhotoView.view, 10), "photo_" + tItem.gphoto.id, tItem.media.content.url);
		
		tLibStack.execute();		
	}
}