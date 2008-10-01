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

import be.netdust.visual.UIContainer;
import be.netdust.visual.UICore;
import be.netdust.visual.events.BubbleEvent;
import be.netdust.visual.managers.FocusManager;
import be.netdust.visual.managers.IFocus;
class be.netdust.visual.containers.DeckBox 
extends UIContainer 
implements be.netdust.visual.managers.ITabGroup
{

	public var styleClass:String = "DeckBox";
	public var selectedPanel:UIContainer = null;
	public var currentItem:UICore = null;
	
	public function set selectedIndex( _nS:Number )
	{
		_index = _nS-1;
	};
	
	public function get selectedIndex( ) : Number
	{
		return _index;
	};
	
	/*
	* Constructor.
	*/
	public function DeckBox( _styleID ) {
		super( _styleID );	
	};
	
	public function getFocusManager() : FocusManager
	{
		return _ofocusManager;
	};
	
	public function onFocus( e:IEvent ) : Void
	{
		if( BubbleEvent(e).getHandle()  == BubbleEvent.REGISTERFOCUS  )
		getFocusManager().registerElement( IFocus( BubbleEvent(e).getSource() ) )
		else {
			selectedPanel = e.getTarget();
			getFocusManager().elementRecievedfocus( IFocus( BubbleEvent(e).getSource() ) )
		}
	};
	
	public function setFocus( _oCurr:IFocus, _oNext:IFocus ) : Void 
	{
		trace( _oCurr.hasFocus() );
	};
	
	public function doLayout() {		
		super.doLayout();	
		
		var l:Number = -1;
		while( l < childs.length-1 ) {
			var _ui:UICore =  childs[++l];	
			_ui.ui._visible = false;
		};
		
		show();
	};
	
	/**
	* @method      DeckBox.addChild
	* @description Adds child to container.
	* @usage       <code>DeckBox.addChild(newChild:Object):Object;</code> 
	*
	* @param    newChild (UICore) object which will be added in the container (component, movie clip or linkage identifier in the FLA file's library).
	*/
	public function addChild( _child:UIContainer ) : Void {
		var childContainer:MovieClip = childs_mc.createEmptyMovieClip( "deckChild" + (++_depth), _depth );

		childs.push(_child);
		_child.setParent( this );
		_child.setContainer( childContainer );		
	};
	
	
	/**
	* @method      DeckBox.show
	* @description Show a specific child.
	* @usage       <code>DeckBox.show(ref):Void;</code> 
	*/
	public function show( ref:String ) : Void 
	{
		var child:UICore;
		
		if( ref == undefined ) child = getChild( _index );
		else child = _findChild( ref );

		if( child != currentItem ) {
			child.ui._visible = true;
			currentItem.ui._visible = false;
		}
		currentItem = child;
		
	};	

	/**
	* @method      DeckBox.showNext
	* @description Show next child.
	* @usage       <code>DeckBox.showNext():Void;</code> 
	*/
	public function showNext() :Void
	{
		( hasNext() ) ? ++_index : _index=childs.length-1;	
		currentItem.ui._visible = false;
		currentItem = childs[_index];
		currentItem.ui._visible = true;		
	};
	
	/**
	* @method      DeckBox.showPrev
	* @description Show prev child.
	* @usage       <code>DeckBox.showPrev():Void;</code> 
	*/
	public function showPrev() : Void
	{
		( _index > 1 ) ? --_index : _index=0;		
		currentItem.ui._visible = false;
		currentItem = childs[_index];
		currentItem.ui._visible = true;		
	};
	
	/**
	* @method      DeckBox.hasNext
	* @description Checks if there are any childs left.
	* @usage       <code>DeckBox.hasNext():Boolean;</code> 
	*/
	public function hasNext() : Boolean 
	{
		return ( childs[_index+1] !=undefined );
	};
	
	private function setup()
	{
		super.setup();
		currentItem = null;
		_ofocusManager = FocusManager.getInstance( getReference(), this );
	};

	/**
	* @method      DeckBox.init
	* @description Initialization of DeckBox.
	* @usage       <code>DeckBox.init():Void;</code> 
	*/
	private function init() : Void
	{
		super.init();	
		layoutmanager.setDirection( null );
	};
	
	private function _findChild( ref:String ) : UICore {
		var l:Number = -1

		while( l < childs.length-1 ) {
			var _ui:UICore =  childs[++l];	
			if( _ui.getReference() == ref ) {
				_index = l;
				return _ui;
			}
		};
		
		return null;
	};
	
	private var _depth:Number = 0;
	private var _index:Number = 0;		
	private var _ofocusManager:FocusManager;
}