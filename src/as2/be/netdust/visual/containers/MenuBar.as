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
import be.netdust.visual.object.MenuItem;
import be.netdust.visual.object.Menu;

class be.netdust.visual.containers.MenuBar 
extends HBox 
{
	public var styleClass:String = "MenuBar";
	
	public var currentMenuItem:MenuItem = null;
	public var currentItem:Menu = null;	
	
	/*
	* Constructor.
	*/
	function MenuBar( _styleID ) {
		super( _styleID );	
	}
	
	private function onSelect( e:IEvent )
	{
		currentItem = e.getTarget();
		currentMenuItem = e.getTarget().currentItem;
		
		if( currentMenuItem instanceof MenuItem )
		currentItem.hide();
	}

	private function onClick( e:IEvent ) {
		currentItem.hide();
		if( currentItem != e.getTarget() ) 
		currentItem = e.getTarget();	
		else currentItem = null;
	};
	
	private function onMenuOver( e:IEvent ) {
		if( currentItem != null ) {
			currentItem.hide();			
			currentItem = e.getTarget();
			currentItem.show();
		}
	};
	
}