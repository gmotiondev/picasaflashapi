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
import com.bourre.events.IEvent;

import be.netdust.visual.object.ScrollTrack;
import be.netdust.visual.object.PushButton;
import be.netdust.visual.layout.styles.Style;
import be.netdust.visual.UIContainer;
import be.netdust.visual.UICore;

class be.netdust.visual.object.ScrollBar extends UIContainer
{
	
	public var autoHide:Boolean = false;
	
	public var button_up:PushButton = null;
	public var button_down:PushButton = null;
	public var scrollbar_track:ScrollTrack = null;
	
	public var styleClass:String = "ScrollBar";	
	
   
    public function set orientation( b:Boolean ) {
        horizontal = b;
    };
	
    public function get orientation() : Boolean {
        return (horizontal);
    };
	
    public function set scrollTarget( scrolltarget : UICore )
    {

		__target = scrolltarget;
		
        if( (scrolltarget instanceof MovieClip ) )   {
			_scroll = "_y";
			_maxscroll = "_height";
        } 
		else {
		
			_scroll = "scroll";
			_maxscroll = "maxscroll";
		}

		height = __target.height  - ( __target.getStyle().vborder );
		update();
    } 
	
    public function get scrollTarget() : Object  {
        return (__target);
    } 
	
    public function get scroll() : Number {
        return ( __target[_scroll] );
    } 
	
	
	public function ScrollBar( _styleID   ) {
		super( _styleID );
	}

	public function setTargetPosition( p:Number ) 
	{
        if (fixThumbAtEnd) {
            isAtBottom = p >= 1;
        } 		
		
		if( p < 1) __target[_scroll] = p * __target[_maxscroll] + 1;
    } 
	
    public function setScroll(n:Number, step:Boolean ) {
		
		if (horizontal) {
            if (step) {
                n *=  __target.width;
            } else {
                n *= 8;
            } 
        } else if (step)   {
            n *= (__target["bottomScroll"] - __target[_scroll] + 1);
        } 

        n+=__target[_scroll];
		
        if (n > __target[_maxscroll] ) {
            n = __target[_maxscroll] ;
        } else if( n < 1 ) { n=1 }


        __target[_scroll] = n;
    } 
	
	public function paint() {
		height = __target.height  - ( __target.getStyle().vborder );
		scrollbar_track.height = height;
		scrollbar_track.height -= getStyle().vmargin;
		scrollbar_track.height -= bttn_u.height + bttn_d.height;
		scrollbar_track.height -= bttn_u.vmargin +  bttn_d.vmargin;	

		super.paint();

		update();
	}

	public function update()
	{
		var diff:Number;
		
        if (horizontal) {
            //var diff:Number = __target.width / __target.textWidth;
        }
        else  {
            var over:Number = ( __target[_maxscroll] +  __target["bottomScroll"] ) - ( __target[_scroll] );
            var avail:Number = (__target["bottomScroll"] > 0 ? __target["bottomScroll"] : 1 ) - __target[_scroll] + 1;
	
			diff = (over) ? avail / over : 1;
        } 

        if( !isNaN(diff ) && diff > 0 ) {
			scrollbar_track.sizeProportion = diff;
			ui._visible = !(diff >= 1 && autoHide);
		} 
		
		if (isAtBottom && __target["maxscroll"] > prevMaxScroll) {
			setTargetPosition(1);
			prevMaxScroll = __target["maxscroll"];
		} 

		if (!scrollbar_track.ui.onMouseMove) {
			scrollbar_track.positionProportion = (__target[_scroll]-1) / (__target[_maxscroll]-1);
		} 
		
    } 
	
	private function onPushInterval( e:IEvent ) 
	{		
		
		switch( e.getTarget() ) {			
			case button_up: setScroll(-1); break;
			case button_down: setScroll(1); break;
		}
		
		if (isAtBottom && __target["maxscroll"] > prevMaxScroll) {
			setTargetPosition(1);
			prevMaxScroll = __target["maxscroll"];
		} 

		if (!scrollbar_track.ui.onMouseMove) {
			scrollbar_track.positionProportion = (__target[_scroll]-1  ) / (__target[_maxscroll]-1 );
		} 
		
	}
	
	private function onScrollTrackPosition ( e:IEvent )
	{
		setTargetPosition( ScrollTrack( e.getTarget() ).getPosition() );
	}
	
	private function setup()
	{		
		super.setup();
		
		ui.tabChildren = false;

		button_up = PushButton.createInstance(  "PushButton",  { label:"", icon:bttn_u.icon, style: bttn_u } );
		button_down = PushButton.createInstance(  "PushButton", { label:"", icon:bttn_u.icon, style: bttn_d } );
		scrollbar_track = ScrollTrack.createInstance(  "ScrollTrack", { style: track } );
		
		addChild(button_up);
		addChild(scrollbar_track);
		addChild(button_down);
	}
	
	private function init()
	{
		super.init();

		bttn_u = getStyle().getSubStyle("min");
		bttn_d = getStyle().getSubStyle("plus");	
		track  = getStyle().getSubStyle("track");

		layoutmanager.setDirection(getStyle().horizontal ? getStyle().horizontal :"vertical");	
	} 	
	
    private var fixThumbAtEnd:Boolean = false;
	private var isAtBottom:Boolean = false;
	private var horizontal:Boolean = false;
	
    private var prevMaxScroll:Number = 0;	
	
	private var __target:UICore = null;
	private var _maxscroll:String = "";
	private var _scroll:String = "";	
	
	private var	bttn_u:Style;
	private var bttn_d:Style;
	private var track:Style;
}
    