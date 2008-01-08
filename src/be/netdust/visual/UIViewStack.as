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
import be.netdust.visual.tools.Rectangle;

import be.netdust.visual.UIScrollView;
import be.netdust.visual.containers.Node;

class be.netdust.visual.UIViewStack
extends UIScrollView
{
	
	/**
	* @method      UIViewStack.childInstance
	* @description gets a childInstance package id
	* @usage       <code>UIViewStack.childInstance():String;</code> 
	*
	*/
	public function get childInstance() : String 
	{
		return _sChildPackage;
	};
	
	/**
	* @method      UIViewStack.childInstance
	* @description sets a childInstance package id
	* @usage       <code>UIViewStack.childInstance(s:String):Void;</code> 
	*
	*/
	public function set childInstance( s:String ) 
	{
		_sChildPackage = s!=null?s:"";
	};
	
	/**
	* @method      UIViewStack.dataProvider
	* @description gets a dataprovider for this stack
	* @usage       <code>UIViewStack.dataProvider():Array;</code> 
	*
	* @return		Array; a array.
	*/
	public function get dataprovider() : DataProvider 
	{
		return _data;
	};
	
	/**
	* @method      UIViewStack.dataProvider
	* @description sets a dataprovider for this stack
	* @usage       <code>Button.dataProvider(_a:Array);</code> 
	*
	*/
	public function set dataprovider( _dp : DataProvider )
	{
		_data = _dp!=null ? _dp : new DataProvider( );
		_data.addListener( this );
		_createChilds();
	};
	
	/**
	* @method      UIViewStack.getItemAt
	* @description gets an item from the stack 
	* @usage       <code>UIViewStack.getItemAt( index:Number ):Object;</code> 
	*
	*/	
	public function getItemAt( index:Number ) : Object 
	{
		return dataprovider.getItemAt( index );
	};
	
	/**
	* @method      UIViewStack.addItem
	* @description adds an item to the stack 
	* @usage       <code>UIViewStack.addItem( item:Object, index:Number );</code> 
	*
	*/	
	public function addItem( item:Object, index:Number )
	{
		dataprovider.addItemAt( index?index:0, item );
	};
	
	/**
	* @method      UIViewStack.removeItem
	* @description removes an item from the stack
	* @usage       <code>UIViewStack.removeItem( item:Object );</code> 
	*
	*/
	public function removeItem( item:Object ) 
	{		
		dataprovider.removeItem( item );
	};
	
	//-------------------------------------------------------------------------
	// Private implementation
	//-------------------------------------------------------------------------	
	/**
	* [Private] Constructor 
	*/
	private function UIViewStack( _styleID ) 
	{
		super( _styleID );		
	}
	
	/**
	* @method      UIViewStack.onModelChanged
	* @description recieves event from dataProvider instance
	* @usage       <code>UIViewStack.onModelChanged( event ):Void;</code> 
	*/	
	private function onModelChanged( event ) 
	{
		paint();
	};
	
	/**
	* @method      UIViewStack.onSort
	* @description recieves event from dataProvider instance
	* @usage       <code>UIViewStack.onSort( event ):Void;</code> 
	*/	
	private function onSort( event ) 
	{
		paint();
	};
	
	/**
	* @method      UIViewStack.init
	* @description Initialization of UIViewStack.
	* @usage       <code>UIViewStack.init():Void;</code> 
	*/
	private function init():Void {
		super.init();		
		layoutmanager.setDirection( "vertical" );
	}
	
	/**
	* @method      UIViewStack._createChilds
	* @description creates default stack childs from dataprovider object
	* @usage       <code>UIViewStack._createChilds( ):Void;</code> 
	*/	
	private function _createChilds( ) 
	{
		var l:Number = -1;	
	
		if( dataprovider.length ) {
			clear();
			while( l < dataprovider.length-1 ) 
			addChild( UIViewStack.createInstance(childInstance, dataprovider.getItemAt(++l)));
		};

	};
	
	private var _sChildPackage:String = "Node";
	private var _data:DataProvider;
	
}
