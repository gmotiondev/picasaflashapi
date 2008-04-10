import com.bourre.commands.Delegate;
import com.bourre.visual.MovieClipHelper;

/**
 * @author Michal Gron (michal.gron@gmail.com)
 */

class view.thumb.Thumb extends MovieClipHelper
{
	private var id : String;
	private var t : TextField;
	
	private var author : String;
	private var title : String;
	private var url : String;

	public function Thumb(name : String, mc : MovieClip, aAuthor : String, aTitle : String, aUrl : String)
	{
		super("thumb_" + name, mc);
		
		id = name;
		author = aAuthor;
		title = aTitle;
		url = aUrl;
		
		view.onRelease = Delegate.create(this, onRelease);
		view.onRollOver = Delegate.create(this, onRollOver);
		view.onRollOut = Delegate.create(this, onRollOut);
	}

	private function onRollOver() : Void
	{
		// zoom in and show infos
		view.swapDepths(view._parent.getNextHighestDepth());
		
		var f : TextFormat = new TextFormat("kroeger", 8, 0xffffff);
			
		view.createTextField("tooltip", 20, 0, 0, 100, 1);
		t = view["tooltip"];
		t.embedFonts = true;
		t.autoSize = "left"; t.background = true; t.backgroundColor = 0xe2007a;
		t.html = true; t.multiline = true;
		t.htmlText = "" + title + "<br/>By: " + author;
		t.setTextFormat(f);
		
		if(t._width > (Stage.width - _root._xmouse)) t._x -= t._width;
	}

	private function onRollOut() : Void
	{
		// zoom out and hide infos
		t.removeTextField();
	}

	private function onRelease() : Void
	{
		// open browser window with link on the photo
		getURL(url,"_blank");
	}
}
