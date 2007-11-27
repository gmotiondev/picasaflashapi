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
import be.netdust.visual.managers.FocusManager;
import be.netdust.visual.managers.IFocus;

import be.netdust.visual.events.BubbleEvent;
import be.netdust.visual.containers.VBox;
import be.netdust.visual.UICore;

import com.bourre.events.IEvent;

class be.netdust.visual.containers.ApplicationView extends be.netdust.visual.containers.VBox implements be.netdust.visual.managers.ITabGroup
{

	/*
	* ApplicationView Constructor.
	*/
	function ApplicationView( _oOwner:UICore, _styleID ) {
		super( _styleID );	
		setContainer( _oOwner?_oOwner:_root );
	}
	
	
	public function getFocusManager() : FocusManager
	{
		return _ofocusManager;
	}
	
	public function onFocus( e:IEvent ) : Void
	{
		if( BubbleEvent(e).getHandle()  == BubbleEvent.REGISTERFOCUS  )
		getFocusManager().registerElement( IFocus( BubbleEvent(e).getSource() ) )
		else
		getFocusManager().elementRecievedfocus( IFocus( BubbleEvent(e).getSource() ) )
	}
	
	public function setFocus( _oCurr:IFocus, _oNext:IFocus ) : Void 
	{
	
	}
	
	
	private function setup()
	{
		super.setup();
		_ofocusManager = FocusManager.getInstance( getReference(), this );
	}

	
	/**
	* @method      ApplicationView.init
	* @description Initialization of ApplicationView.
	* @usage       <code>ApplicationView.init():Void;</code> 
	*/
	private function init():Void 
	{
		super.init();	
		getStyle().width = Stage.width;
		getStyle().height = Stage.height;
	}
	
	private var _ofocusManager:FocusManager
}