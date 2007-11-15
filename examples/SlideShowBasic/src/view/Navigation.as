import com.bourre.visual.MovieClipHelper;
import com.bourre.commands.Delegate;
import com.bourre.events.EventBroadcaster;import com.bourre.transitions.TweenMS;

import control.*;

/**
 * @author Michal Gron (michal.gron@gmail.com) */
class view.Navigation extends MovieClipHelper
{
	public var container:MovieClip;
	private var __message:MovieClip;
	
	public function Navigation(sID:String,aC:MovieClip)
	{
		super(sID,aC);
		
		container = aC.createEmptyMovieClip("nav",2);
		initialize();
	}
	
	private function initialize():Void
	{
		var l:MovieClip = container.attachMovie("l","l",1002);
		var r:MovieClip = container.attachMovie("r","r",1003);
		
		l._x = 5; l._y = 5;
		r._x = 275; r._y = 5;
		
		l.onRelease = Delegate.create(this, onPrevPhoto);		r.onRelease = Delegate.create(this, onNextPhoto);
		
		l.onRollOver = r.onRollOver = Delegate.create(this, onContainerOver);
		r.onRollOut = r.onRollOut = Delegate.create(this, onContainerOut);
		
		onContainerOut();
	}
	
	private function onContainerOver():Void
	{
		show();
		var t:TweenMS = null;
			t = new TweenMS(container, '_alpha', 100, 150, 0);
			t.start();
	}
	
	private function onContainerOut():Void
	{
		container._alpha = 0;
	}
	
	private function onPrevPhoto():Void
	{
		printMessage("CLICK TO PLAY!");
		
		EventBroadcaster.getInstance().broadcastEvent(new SlideShowPauseEvent(true));
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetPreviousEvent());
		protect();
	}
	
	private function onNextPhoto():Void
	{
		printMessage("CLICK TO PLAY!");
		
		EventBroadcaster.getInstance().broadcastEvent(new SlideShowPauseEvent(true));
		EventBroadcaster.getInstance().broadcastEvent(new PhotoGetNextEvent());
		protect();
	}
	
	private function onStartSlideShow():Void
	{
		EventBroadcaster.getInstance().broadcastEvent(new SlideShowPauseEvent(false));
		clearMessage();
	}
	
	private function printMessage(aString:String):Void
	{
		__message = view.createEmptyMovieClip("message",5);
		
		var tTF:TextFormat = new TextFormat();
			tTF.font = "london";
			tTF.size = 12;
			tTF.leading = -16;
			tTF.blockIndent = 10;
			tTF.color = 0x003C63;
			
		__message.createTextField("message_text", 2, 0, 0, 320, 20);
		var tF:TextField = __message.message_text;
			tF.embedFonts = true;
			tF.multiline = true;
			tF.selectable = false;
			tF.html = true;
			tF.htmlText = ""+aString;
			tF.setTextFormat(tTF);
			
		__message._y = 223;
		__message.onRelease = Delegate.create(this, onStartSlideShow);
	}
	
	private function clearMessage():Void
	{
		__message.removeMovieClip();
	}
	
	private function protect():Void
	{
		container.r.onRelease = container.l.onRelease = null;
		
		var t:TweenMS = null;
			t = new TweenMS(null, '_alpha', 0, 500, 0);
			t.addEventListener(TweenMS.onMotionFinishedEVENT, this, unprotect);
			t.start();
	}
	
	private function unprotect():Void
	{
		container.l.onRelease = Delegate.create(this, onPrevPhoto);
		container.r.onRelease = Delegate.create(this, onNextPhoto);
	}
}
