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
import com.bourre.log.PixlibStringifier;

import be.netdust.visual.assembler.IAssembler;
import be.netdust.visual.assembler.expert.*;
class be.netdust.visual.assembler.ViewAssembler
implements IAssembler
{
	public function ViewAssembler(  ) {

	}
	
	public function create( _scope, _instanceid:String ) {
		ComponentExpert.getInstance( this ).createView( _scope, _instanceid );
	};
	
	public function buildStyle( _style:String ) {
		StyleExpert.getInstance( this ).buildStyle( _style );
	};
	
	public function buildStyleProperty( _instance, _style:String ) {
		StyleExpert.getInstance( this ).buildStyleProperty( _instance, _style );
	};
		
	public function buildScript( _script:String ) {
		//ScriptExpert.getInstance( this ).buildScript( _script );
	};
	
	public function buildKeyAccess( _instance, _key:String ) {
		ToolExpert.getInstance( this ).buildKeyAccess( _instance, _key );
	};
	
	public function buildToolTip( _instance, _value:String ) {
		ToolExpert.getInstance( this ).buildToolTip( _instance, _value );
	};
	
	public function buildDataProvider( _sid:String, _data:Array ) {
		DataExpert.getInstance( this ).buildDataProvider( _sid, _data );
	};
	
	public function buildAttributeProperty( _instance, _attr:Object ) {
		PropertyExpert.getInstance( this ).buildAttributeProperty( _instance, _attr );
	}
	
	public function buildPropertyMethod( _instance, _method:String ) {
		MethodExpert.getInstance( this ).buildPropertyMethod( _instance, _method );
	};
	
	public function buildViewContainer( id:String ) {
		return ComponentExpert.getInstance( this ).buildViewContainer( id );
	};
	
	public function buildComponent( object:String, id:String, style:String, label:String, type:String ) {		
		return ComponentExpert.getInstance( this ).buildComponent( object, id, style, label, type );
	};	
	
	public function toString() : String 
	{
		return PixlibStringifier.stringify(this);
	}
	
	private function _init()
	{

	}

}