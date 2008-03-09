/** * Copyright (c) 2007 Stefan Vandermeulen - netdust.be 
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.UIObject;

class be.netdust.visual.object.ScrollTrack
extends UIObject
{

	public var styleClass:String = "ScrollTrack";	
		
	public var track:MovieClip = null;	
	public var thumb:MovieClip = null;
	

	
	public function get trackSize() : Number {
        return ( ( getStyle().height - ( getStyle().vmargin ) ) - ( thumbstyle.height - ( thumbstyle.vmargin ) )  );
    } 
	
    public function set positionProportion( _prop:Number ) {
		_prop=(_prop>1)? 1:((_prop<0)?0:_prop);
		thumb._y = initposition + ( _prop*trackSize );   
    } 
	
	function set sizeProportion( _prop:Number )
    {
        if (_prop > 1) {
            _skin.draw( thumb, thumbstyle.width, height, thumbstyle );
			thumbstyle.height = height;
            prevThumbProp = 1;
        }
        else {
            thumb._visible = true;
            
			if (prevThumbProp != _prop) {   
				_skin.draw( thumb, thumbstyle.width, _prop*height, thumbstyle );
				thumbstyle.height = _prop*height;
                prevThumbProp = _prop;
            } 			
        } 
    } 
	
	public function ScrollTrack( _styleID ) {
		super( _styleID );
	}
	
	public function getPosition() : Number
	{
		return _pos;
	}
	
	public function paint(  ) {	
		_skin.draw( ui, getStyle().width, getStyle().height, getStyle() );
		_skin.draw( thumb, thumbstyle.width, thumbstyle.height, thumbstyle );
	};
	
	public function doLayout() {
		thumb._x = (isNaN(getStyle().paddingLeft)?0:getStyle().paddingLeft)
		thumb._y = initposition;
	}

	private function onTrack() {
        var ystep:Number = ui._ymouse < thumb._y ? (-1) : (1);

        if (ystep == -1) {
            thumb._y = ( ui._ymouse > initposition ) ? ui._ymouse : initposition;
        } else {
            thumb._y = ( ui._ymouse - thumbstyle.height ) < ( getStyle().height  - ( thumb._height + getStyle().paddingBottom) ) ? ( ui._ymouse - thumbstyle.height ) : ( getStyle().height  - ( thumb._height + getStyle().paddingBottom) );
        } 
        changePosition();	
    } 
	
    private function onThumbDown() {
        thumb.startDrag(false, getStyle().paddingLeft, initposition, getStyle().paddingRight, getStyle().height  - ( thumb._height + getStyle().paddingBottom) );
        ui.onMouseMove = Delegate(this, changePosition);
    } 
	
    private function onThumbUp() {
        thumb.stopDrag();
        delete ui.onMouseMove;
    }
	
    private function changePosition( pos:Number ) {
        if (pos == undefined)  {
            _pos = ( thumb._y - ( getStyle().vpadding )) / ( trackSize );
        } 	
        callObserver( "onScrollTrackPosition" );
    } 

	private function setup() {
		super.setup()
		
		track = ui.createEmptyMovieClip( "track", 1 );
		thumb = ui.createEmptyMovieClip( "thumb", 2 );

		//track = ui.attachMovie( getStyle().skin,  "track", 1 );
		//thumb = ui.attachMovie( thumbstyle.skin, "thumb", 2 );

		track.useHandCursor = thumb.useHandCursor = false;
		
		track.onPress = Delegate(this, onTrack);       
		thumb.onPress = Delegate(this, onThumbDown);
        thumb.onRelease = thumb.onReleaseOutside = Delegate(this, onThumbUp);
	}
	
	private function init() {		
		super.init();					
		initposition = getStyle().paddingTop;
		thumbstyle = getStyle().getSubStyle("thumb");
	}
	
	private var _pos:Number = 0;
	private var thumbstyle:Style;
	private var initposition:Number = 0;
	private var prevThumbProp:Number = 0;
}