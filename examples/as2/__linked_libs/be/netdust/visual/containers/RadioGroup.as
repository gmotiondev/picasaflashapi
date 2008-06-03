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

import be.netdust.visual.containers.TitleBox;
import be.netdust.visual.object.RadioButton;
class be.netdust.visual.containers.RadioGroup
extends TitleBox
{
	
	public var currentItem:RadioButton = null;
	
	public function RadioGroup( _label:String, _styleID )
	{
		super( _label, _styleID );	
	};
	
	/**
	* @method      RadioGroup.init
	* @description Initialization of RadioGroup.
	* @usage       <code>RadioGroup.init():Void;</code> 
	*/
	private function init():Void
	{
		super.init();		
	}
	
	private function onClick( e:IEvent ) 
	{
		if( currentItem != e.getTarget() ) 
		{
			currentItem.selected = false;
			currentItem = e.getTarget();	
			dispatchEvent( ON_CLICK_EVENT );
		}
	}

}