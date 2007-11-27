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
import be.netdust.visual.data.DataProvider;
import be.netdust.visual.containers.VBox;
import be.netdust.visual.object.MenuItem;

class be.netdust.visual.containers.MenuPopup 
extends VBox 
{
	public var styleClass:String = "MenuPopup";
	
	public function set dataprovider( dp:DataProvider )
	{
		_oDataProvider = dp;
		populate();
	}
	
	public function get dataprovider( ) : DataProvider
	{
		return _oDataProvider;
	}
	
	/*
	* Constructor.
	*/
	function MenuPopup( _styleID ) {
		super( _styleID );	
		setContainer();
	}
	
	public function setContainer() {
		container = _root;
	}
	
	public function setPosition( _nx:Number, _ny:Number ) {
		x= ui._x = _nx;
		y= ui._y = _ny;
	}

	public function show() {
		callObserver( "getMenuPosition" ); 
		ui._visible = true;
	};
	
	public function hide() {
		ui._visible = false;
	};
	
	public function isShowing():Boolean {
		return ui._visible;
	};
	
	public function addChild( _child ):Void
	{
		_child.setParent( this );
		_child.setObserver( getParent() );
		childs.push(_child);
	};
	
	/**
	* @method      MenuPopup.setup
	* @description Setup of MenuPopup instance mc .
	* @usage       <code>MenuPopup.setup():String;</code> 
	*/
	private function setup() {
		if( ui==null ) super.setup();	
		ui._visible = false;
	};
	
	private function init()
	{
		super.init();
		Mouse.addListener( this );
	}
	
	private function onMouseDown()
	{
		var o:Object = new Object();
		o.x = ui._xmouse;
		o.y = ui._ymouse;
    	ui.localToGlobal(o);

		if( !ui.hitTest(o.x, o.y, false) ) {
			//hide();
		}
	}
	
	private function populate()
	{
		clear();
		var _data:Array = _oDataProvider.getData();
		var l:Number = -1;
		while( l < _data.length-1 ) {
			addChild( new MenuItem( _oDataProvider.getItemAt( ++l ).label, null ) );
		}
	}

	private var _oDataProvider:DataProvider

}