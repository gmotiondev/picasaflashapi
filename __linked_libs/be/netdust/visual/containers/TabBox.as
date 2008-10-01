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

import be.netdust.visual.containers.HBox;
import be.netdust.visual.containers.TabPanels;
import be.netdust.visual.object.Tab;
class be.netdust.visual.containers.TabBox 
extends be.netdust.visual.containers.VBox 
{

	public var styleClass:String = "TabBox";		
	public var currentItem:Tab = null;

	
	/*
	* Constructor.
	*/
	public function TabBox( _styleID ) 
	{
		super( _styleID );	
	}

	public function doLayout() 
	{
		super.doLayout();
		currentItem.selected = true;			
	}


	private function setup()
	{
		super.setup();
		
		_tabButtonContainer = HBox( getChild(0) );
		_tabPanelContainer = TabPanels( getChild(1) );				
		
		for( var c:String in _tabButtonContainer.childs ) {
			var child = _tabButtonContainer.getChild(c);
			child.panelReference = _tabPanelContainer.getChild(c).getReference();
			child.setObserver( this );
		};
		
		if( currentItem == null )
		currentItem = Tab( _tabButtonContainer.getChild( _tabPanelContainer.selectedIndex ) );	
	}
	
	private function onClick( e:IEvent )
	{
		if( currentItem != e.getTarget() ) 
		currentItem.selected = false;
		currentItem = e.getTarget();
		_tabPanelContainer.show( currentItem.panelReference );	
	}
	
	private var _tabButtonContainer:HBox;
	private var _tabPanelContainer:TabPanels;

}