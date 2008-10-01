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
import be.netdust.visual.containers.Node;
import be.netdust.visual.object.Label;
class be.netdust.visual.object.ListCell
extends Label
{

	public function ListCell( _sValue:String, _styleID ) {
		super( _sValue, _styleID );	
	};
	
	public function setImage( _icon:String )
	{
		_sIconID = _icon;
	};
	
	public function doLayout() 
	{
		_labeltf.text = getLabel();
		_labeltf.autoSize = "left";	

		width = _labeltf._width + getStyle().hpadding + getStyle().hborder;

		if( _sIconID!= undefined )
		{
			icon.attachMovie( _sIconID, "icon", 1 );			
			icon._y = Node( getParent() ).height/2 - icon._height/2;	
			icon._x = getStyle().paddingLeft;
			icon._visible = true;
		}
	};
	
	private function setup() 
	{
		super.setup();

		if( ui.icon!=undefined ) icon = ui.icon
		else {
			icon = ui.createEmptyMovieClip( "icon", 2 );
			icon._visible = false;
		}
	};
	
	private var _sIconID:String = null;
	private var icon:MovieClip = null;
}