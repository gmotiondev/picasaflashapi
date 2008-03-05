import com.bourre.visual.MovieClipHelper;
import com.bourre.transitions.TweenMS;

import control.photo.PhotoChangedEvent;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.photo.Photo extends MovieClipHelper
{
	private var id:String;

	public function Photo(aID:String, aContainer:MovieClip, aHide:Boolean)
	{
		super(aID, aContainer);
		
		id = aID;
	
		setVisible(!aHide);
		move(0, 21);
	}
	
	// listen to the model
	public function photo_changed_event(evt : PhotoChangedEvent) : Void
	{
		var t:TweenMS = null;
		
		if(evt.id == id)
		{	
			t = new TweenMS(view, '_alpha', 100, 250, 0);	
			show();
		} else
		{
			if(isVisible())
			{
				t = new TweenMS(view, '_alpha', 0, 250, 100);
				t.addEventListener(TweenMS.onMotionFinishedEVENT, this, hide);
			}
		}
		
		t.start();
	}
}
