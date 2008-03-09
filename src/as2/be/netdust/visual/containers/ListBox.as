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
import be.netdust.visual.object.ScrollBar;
import be.netdust.visual.object.ListItem;
import be.netdust.visual.UICore;
import com.bourre.events.IEvent;

class be.netdust.visual.containers.ListBox extends be.netdust.visual.UIViewStack
{
	public var styleClass:String = "ListBox";
	public var currentItem:ListItem = null;	

	/**
	* Constructor
	*/
	public function ListBox( _styleID ) 
	{
		super( _styleID  );
	};
	
	/**
	* @method      ListBox.paint
	* @description paints ListBox on screen
	* @usage       <code>ListBox.paint( ):Void;</code> 
	*/
	public function paint() : Void
	{
		super.paint();			
		if( _listheader!= undefined ) _listheader.paint();			
	}	
	
	/**
	* @method      ListBox.addChild
	* @description adds a child to ListBox
	* @usage       <code>ListBox.addChild( _child:UICore ):Void;</code> 
	*/
	public function addChild( _child:UICore ) : Void
	{		
		super.addChild( _child );
		_child.getStyle().backgroundAlpha = childs.length%2 ? 80 : 60;			
	};
	
	/**
	* @method      ListBox.onClick
	* @description recevies onClick event from ListItem
	* @usage       <code>ListBox.onClick():Void;</code> 
	*/
	private function onClick( e:IEvent ) {
		if( currentItem != e.getTarget() ) 
		{
			currentItem.selected = false;
			currentItem = e.getTarget();
			dispatchEvent( ON_CLICK_EVENT );
		}
	};
	
	/**
	* @method      ListBox.init
	* @description Initialization of ListBox.
	* @usage       <code>ListBox.init():Void;</code> 
	*/
	private function init() : Void
	{
		super.init();		
		_listcols = new Array();
		_listheader = new Object();
	};
	
	
	private var _selected:ListItem;	
	private var _listcols:Array = null;
	private var _listheader:Object = null;
	
	private var _sChildPackage:String = "ListItem";

}
