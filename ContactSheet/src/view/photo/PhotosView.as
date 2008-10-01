import com.bourre.visual.MovieClipHelper;

import view.photo.Photo;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.photo.PhotosView extends MovieClipHelper
{	
	public function PhotosView(aId : String, aC : MovieClip)
	{
		super(aId, aC);
	}
	
	public function addChild(aId : String, aUrl : String) : Photo
	{
		var tHolder : MovieClip = view.createEmptyMovieClip("photo_holder_" + aId, view.getNextHighestDepth());
		
		return new Photo(aId, tHolder, aUrl);
	}
}