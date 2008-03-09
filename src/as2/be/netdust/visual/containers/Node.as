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
import be.netdust.visual.containers.HBox;
import be.netdust.visual.object.ListCell;
import be.netdust.visual.object.Label;

import com.bourre.events.BasicEvent;
import com.bourre.events.EventType;

class be.netdust.visual.containers.Node
extends HBox
{
	public var currentItem:ListCell = null;
	
	public function set selected( _bSel:Boolean )
	{
		_select= _bSel;	
		if( selected ) _onStateHandler( "select" );
		else _onStateHandler( "deselect" );
	};
	
	public function get selected( ) : Boolean 
	{
		return _select; 
	};
	
	public function Node( _styleID ) 
	{
		super( _styleID );	
	};	
	
	public function setSize()
	{
		
	}
	
	private function _onStateHandler( _state:String ) 
	{		
		_skin.setState( ui, _state, getStyle() );

		switch( _state )
		{
			case "release": 
				selected = true;
				callObserver("onCommand"); 
				dispatchEvent( new BasicEvent( new EventType("onClick") ) );
			break;
			case "press": callObserver("onFocus"); break;
			case "over": break;
			case "out": break;			
		}	

		if( selected ) {
			_skin.setState( ui, "selected", getStyle() );
		}
	}
	
	private function setup() 
	{
		super.setup();			
	
		ui.onPress = Delegate( this, _onStateHandler, "press" );
		ui.onRollOut = Delegate( this, _onStateHandler, "out" );
		ui.onRollOver = Delegate( this, _onStateHandler, "over" );
		ui.onRelease = Delegate( this, _onStateHandler, "release" );
		ui.onDragOutside = Delegate( this, _onStateHandler, "releaseout" );
		ui.onReleaseOutside = Delegate( this, _onStateHandler, "releaseout" );
	}
	
	private var _select:Boolean = false;

}