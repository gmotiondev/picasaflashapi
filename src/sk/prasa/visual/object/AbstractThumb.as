/**
 * @author michal.gron@gmail.com
 */
import com.bourre.visual.MovieClipHelper;
import com.bourre.utils.Geom;

class sk.prasa.visual.object.AbstractThumb extends MovieClipHelper
{
	private var __background:MovieClip;
	private var id:String;
	private var title:String;
	
	public function AbstractThumb(aId:String, aContainer:MovieClip, aTitle:String)
	{
		super(aId, aContainer);
		
		id = aId;
		title = aTitle;
	}
	
	public function setBackground(aColor:Number, aHighlight:Number, aMargin:Number):Void
	{
		__background 		= Geom.buildRectangle(view, 2, (0+(2*aMargin)), (0+(2*aMargin)), aColor, aColor);
		__background._x 	= -aMargin;
		__background._y 	= -aMargin;
		__background.__c 	= aColor;
		__background.__h 	= aHighlight;
	}
	
	public function getBackground():MovieClip
	{
		return __background;
	}
	
	private function setHighlight(aTrigger:Boolean):Void
	{
		with(new Color(getBackground())) { setRGB((aTrigger ? getBackground().__h : getBackground().__c)); }
	}	
}