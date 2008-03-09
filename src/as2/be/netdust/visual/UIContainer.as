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

/**
* 
* 	    CONTAINERS LAYOUT
* 
* 
*  <-------   WIDTH   ------->
* |---------------------------| ^
* |		   B O R D E R        | |
* |  |---------------------|  | |
* |	 |	 P A D D I N G T   |  | |
* |  |P	|---------------|P |  | 
* |B |A	|               |A |B | H
* |O |D	|               |D |O | E
* |R |D	|	   BOX      |D |R | I
* |D |I	|    CONTENT    |I |D | G
* |E |N	|               |N |E | H
* |R |G	|               |G |R | T
* |  |L	|---------------|R |  | 
* |	 |	 P A D D I N G B   |  | |
* |  |---------------------|  | |
* |		   B O R D E R        | |
* |---------------------------| _
* 
* 
*/

import be.netdust.visual.managers.LayoutManager;
import be.netdust.visual.UICore;

class be.netdust.visual.UIContainer extends UICore 
{
	public var childs:Array = null;
	public var childs_mc:MovieClip = null; 
	public var styleClass:String = "Container";		
	public var layoutmanager:LayoutManager = null;	

	
	/**
	* @method      UIContainer.width
	* @description Returns width of UIContainer, in pixels.
	* @usage       <code>UIContainer.width:Number;</code> 
	*
	* @return	Number; width of UIContainer, in pixels.
	*/
	public function get width():Number 
	{
		return getStyle().width;
	};
	
	/**
	* @method      UIContainer.width
	* @description Sets width of UIContainer, in pixels.
	* @usage       <code>UIContainer.width:Number;</code> 
	*
	* @return	Number; width of UIContainer, in pixels.
	*/
	public function set width( w:Number ) : Void
	{
		getStyle().width = w; 
	};
	
	/**
	* @method      UIContainer.height
	* @description Returns height of UIContainer, in pixels.
	* @usage       <code>UIContainer.height:Number;</code>
	*
	* @return	Number; height of UIContainer, in pixels.
	*/
	public function get height():Number 
	{
		return getStyle().height;
	};	
	
	/**
	* @method      UIContainer.height
	* @description Sets height of UIContainer, in pixels.
	* @usage       <code>UIContainer.height:Number;</code> 
	*
	* @return	Number; height of UIContainer , in pixels.
	*/
	public function set height( h:Number ) : Void
	{
		getStyle().height = h;
	};
	
	/**
	* @method      UIContainer.getContentWidth
	* @description Gets width of UIContainers contentbox.
	* @usage       <code>UIContainer.getContentWidth:Number;</code> 
	*
	* @return	Number; width of UIContainer contentbox, in pixels.
	*/
	public function getContentWidth(  ) : Number
	{
		return width - ( getStyle().hpadding + getStyle().hborder ); 
	};
	
	/**
	* @method      UIContainer.getContentHeight
	* @description Gets height of UIContainers contentbox.
	* @usage       <code>UIContainer.getContentHeight:Number;</code> 
	*
	* @return	Number; height of UIContainer contentbox, in pixels.
	*/
	public function getContentHeight(  ) : Number
	{
		return height - ( getStyle().vpadding + getStyle().vborder );
	};
	
	/**
	* @method      UIContainer.setFlex
	* @description Sets the flexiblity of UIContainer, if true container will take in space of parent
	* @usage       <code>UIContainer.setFlex(val:Boolean):Void;</code>
	*/
	public function setFlex( val:Boolean ) : Void
	{
		_flex = val;
		
		if( _flex ){
			if( width != undefined && width != 0 ) getStyle().minwidth = width;
			if( height != undefined && height != 0 ) getStyle().minheight = height;
		}
		else {
			getStyle().minwidth = null;
			getStyle().minheight = null;
		}
	};
	
	/**
	* @method      UIContainer.getFlex
	* @description Gets the flexiblity of UIContainer
	* @usage       <code>UIContainer.getFlex( ):Boolean;</code>
	*/
	public function getFlex(  ) : Boolean
	{
		return _flex;
	};
	
	/**
	* @method      UIContainer.setOrient
	* @description Sets the orientation of UIContainer.
	* @usage       <code>UIContainer.setOrientation(val:String):Void;</code>
	*/
	public function setOrient( val:String ) : Void
	{
		super.setOrient(val);
		layoutmanager.setDirection( val );
	};
	
	/**
	* @method      UICore.setAlign
	* @description Sets the alignment of UIContainer's children.
	* @usage       <code>UIContainer.setAlign(val:String):Void;</code>
	*/
	public function setAlign( val:String ):Void
	{
		_salign = val;
	};
	
	/**
	* @method      UIContainer.getAlign
	* @description Gets the alignment of UIContainer.
	* @usage       <code>UIContainer.getAlign():String;</code>
	*/
	public function getAlign() : String
	{
		return _salign;
	};	
	
	/**
	* @method      UICore.setPack
	* @description Sets the opposite alignment of UIContainer's children.
	* @usage       <code>UIContainer.setPack(val:String):Void;</code>
	*/
	public function setPack( val:String ) : Void
	{
		_spack = val;
	};
	
	/**
	* @method      UIContainer.getPack
	* @description Gets the opposite alignment of UIContainer.
	* @usage       <code>UIContainer.getPack():String;</code>
	*/
	public function getPack() : String
	{
		return _spack;
	};	
	
	/**
	* @method      UIContainer.getContents
	* @description Return reference to the element.
	* @usage       <code>UIContainer.getContents():MovieClip;</code> 
	*
	* @return	reference to the element.
	*/
	public function getContents():MovieClip
	{
		return childs_mc;
	};	
	
	/**
	* @method      UIContainer.paint
	* @description Paints skin into ui.
	* @usage       <code>UICore.paint():Void;</code> 
	*
	*/
	public function paint( ) : Void 
	{
		if(childs.length) createChild();

		_skin.draw( ui, width, height, getStyle() );
		
		doLayout();
	};
	
	/**
	* @method      UIContainer.doLayout()
	* @description Public method for placing elements of container.
	* @usage       <code>UIContainer.doLayout():Void;</code> 
	*/
	public function doLayout() : Void 
	{
		layoutmanager.doAlign();
		childs_mc._x = getStyle().paddingLeft + getStyle().borderLeftWidth;
		childs_mc._y = getStyle().paddingTop + getStyle().borderTopWidth;

	};
	
	/**
	* @method      UIContainer.doMask()
	* @description Creates a mask for UIContainer contents.
	* @usage       <code>UIContainer.doMask():Void;</code> 
	*/	
	public function doMask() : Void
	{
		mask_mc = ui.createEmptyMovieClip("mask", 5);
	 	childs_mc.setMask( mask_mc );

		_skin.draw( mask_mc, getContentWidth(), getContentHeight(), getStyle() );	
	}
	
	/**
	* @method      UIContainer.getChild
	* @description Gets a child from container.
	* @usage       <code>UIContainer.getChild( id:Number ):UICore;</code> 
	*
	* @param    id    (Number) position of child in container
	*
	* @return   Object; reference to the child.
	*/
	public function getChild( id:Number ) : UICore
	{		
		return childs[id];
	};
	
	/**
	* @method      UIContainer.addChild
	* @description Adds child to container.
	* @usage       <code>UIContainer.addChild(newChild:Object ):Object;</code> 
	*
	* @param    newChild    (Object) object which will be added in the container (component, movie clip or linkage identifier in the FLA file's library).
	*
	* @return   Object; reference to the child.
	*/
	public function addChild( _child:UICore ) : Void
	{
		_child.setParent( this );
		childs.push(_child);
	};
	
	/**
	* @method      UIContainer.createChild
	* @description createChild child instances.
	* @usage       <code>UIContainer.createChild():Void;</code> 
	*
	*/	
	public function createChild(  ) : Void 
	{	
		var l:Number = -1;
		layoutmanager.reset( getStyle() );	

		while( l < childs.length-1 ) {
			var _ui:UICore =  childs[++l];				
			_ui.create( );
			
			if (layoutmanager.getDirection() != null) {
				layoutmanager.position( _ui );
			};
		};	
		
		layoutmanager.getSize();			
	};
	
	
	/**
	* @method      UIContainer.removeChild
	* @description Removes the child.
	* @usage       <code>UIContainer.removeChild(id:String):Void;</code> 
	*/
	public function removeChild(id:Number):Void 
	{
		childs[id].destroy();
		childs.splice(id, 1);
	};	
	
	/**
	* @method      UIContainer.removeChilds
	* @description Removes all childs.
	* @usage       <code>UIContainer.removeChilds():Void;</code> 
	*/
	public function removeChilds():Void 
	{
		while(childs.length) {
			var child:Object = childs.shift();
			UICore(child).destroy();
		}
	};	
	
	/**
	* @method      UIContainer.destroy
	* @description Destroys this container and it's children.
	* @usage       <code>UIContainer.destroy():Void;</code> 
	*/
	public function destroy() : Void 
	{
		removeChilds();		
		super.destroy();
	};
	
	
	/**
	* @method      UIContainer.clear
	* @description Cleares all child instances.
	* @usage       <code>UIContainer.clear():Void;</code> 
	*/
	public function clear( ):Void 
	{
		var l:Number = -1

		while( l < childs.length-1 ) {
			var child:UICore = childs[++l];
			child.clear();
		}
		
		super.clear();
	};	
	

	
	/**
	* private constructor
	* @param style
	*/
	private function UIContainer( _styleID ) 
	{
		super( _styleID!=undefined?_styleID:null );	
	};
	
	/**
	* @method      Container.setup
	* @description Initialization of container children.
	* @usage       <code>Container.setup():Void;</code> 
	*/
	private function setup( ) : Void 
	{
		super.setup();
		childs_mc = ui.createEmptyMovieClip("childs", 3);
	};
	
	/**
	* @method      Container.init
	* @description Initialization of container variables.
	* @usage       <code>Container.init():Void;</code> 
	*/
	private function init() : Void
	{
		super.init();
		
		childs = new Array();
		layoutmanager = new LayoutManager( getOrient(), this );
		
		if( width != undefined && width != 0 ) getStyle().maxwidth = width;
		if( height != undefined && height != 0 ) getStyle().maxheight = height;
	};
	
	
	private var mask_mc:MovieClip;
	
	private var _salign:String = null;
	private var _spack:String = null;
	
	private var _flex:Boolean = false;
	
}